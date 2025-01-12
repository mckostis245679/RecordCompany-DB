-- 3.1.3.1 calculate venue score

delimiter $$

create procedure CalcVenueScore (IN venueID_in int)
begin
  declare score DECIMAL(8,2);
  select (Capacity / 1000) + (NumofConcerts / 100) * 3 + (OperationYears * 2) into score from venue where VenueID = venueID_in;
  update venue set rating = score where VenueID = venueID_in;
end $$

delimiter ;


-- 3.1.3.2 concert management

delimiter $$

create procedure manage_concert (IN artist_ID_in INT, IN concert_date_in DATE, IN action_type_in CHAR(1))
begin
     DECLARE msg_out VARCHAR(100);
    DECLARE concert_status varchar(20);

    declare new_concert_id int;
    
    SELECT ConcertStatus into concert_status from concert where ArtistID = artist_ID_in AND  ConcertDate = concert_date_in limit 1;

    CASE action_type_in
        -- Schedule a new concert
        WHEN 'i' THEN
            if concert_status = 'Scheduled' then
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'A concert is already scheduled for this artist on the given date.';
            ELSEIF concert_status = 'Cancelled' then
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'A concert was cancelled for this artist on the given date.';
            ELSE
                -- INSERT A CONCERT WITHOUT A VENUE (it has to exist so we can call FindVenue)
                insert into concert (ConcertStatus, ConcertDate, required_capacity, ArtistID) values
                                    ('Scheduled', concert_date_in, 0, artist_ID_in);

                -- Assign venue to concert !!! IT ASSIGNS VENUE WITH HARD-CODED REQUIRED CAPACITY) !!!
                select count(*) from concert into new_concert_id;
                
                call FindVenue(new_concert_id, 1000, @sel_venueid, @sel_capacity);
                update concert set VenueID = @sel_venueid, required_capacity = @sel_capacity where ConcertID = new_concert_id;
                
                set msg_out = 'Concert scheduled successfully. Assigning venue...';
            END IF;

        -- Cancel an existing concert
        WHEN 'c' THEN
            IF concert_status = 'Scheduled' THEN
                UPDATE concert SET ConcertStatus = 'Canceled'
                WHERE ArtistID = artist_ID_in AND ConcertDate = concert_date_in;
                set msg_out = 'Concert successfully cancelled.';
            ELSEIF concert_status is null then
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'No concert exists for given artist and date.';
            ELSE
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'The concert is already cancelled.';
            END IF;

        -- Reactivate a canceled concert
        WHEN 'a' THEN
            IF concert_status = 'Canceled' THEN
                UPDATE concert SET ConcertStatus = 'Scheduled'
                WHERE ArtistID = artist_ID_in AND ConcertDate = concert_date_in;
                SET msg_out = 'Concert successfully reactivated.';
            ELSEIF concert_status IS NULL THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'No cancelled concert exists for this artist on the given date.';
            ELSE
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'The concert is already scheduled.';
            END IF;

        -- Invalid action type
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid action type. Use "i", "c", or "a".';
    END CASE;

    SELECT msg_out AS message;

end $$

delimiter ;

-- 3.1.3.3 Find venue
delimiter $$

create procedure FindVenue (IN concert_id_in INT, IN req_capacity_in INT, OUT selected_venue_id INT, OUT selected_capacity INT)
begin
  declare concert_status varchar(20);
  declare assigned_venue_id int;

  select ConcertStatus, VenueID into concert_status, assigned_venue_id from concert
  where ConcertID = concert_id_in LIMIT 1;
  
  if concert_status is null then
      set selected_capacity = 0;
      set selected_venue_id = null;
  elseif assigned_venue_id is not null then
      -- Return the already assigned venue from the concert
      select VenueID, Capacity into selected_venue_id, selected_capacity from venue where VenueID = assigned_venue_id;
  else
      select VenueID, Capacity into selected_venue_id, selected_capacity from venue
      where Capacity >= (1.1 * req_capacity_in)
        AND not exists (select 1 from concert where concert.VenueID = venue.VenueID AND ConcertStatus = 'Scheduled')
        ORDER BY rating DESC LIMIT 1;
  end if;
end $$

delimiter ;


-- INDEXES for procedure optimization

create index concert_status_idx on concert(ConcertStatus);
create index concert_date_idx on concert(ConcertDate);
create index concert_venue_capacity_idx on venue(Capacity);
create index concert_history_tickets_idx on ConcertHistory(ticket_count);  
create index concert_history_venue_idx on ConcertHistory(venue_name);

-- 3.1.3.4a Find concerts by tickets sold range
delimiter $$

create procedure Find_Concerts_byTickets(IN min INT, IN max INT)
begin
  select distinct artist_name from ConcertHistory
  where ticket_count between min and max;
end $$

delimiter ;

-- 3.1.3.4b find concert dates by venue name
delimiter $$

create procedure Find_Concert_byVenue(IN venue_name_in varchar(100))
begin
  select concert_date from ConcertHistory
  where venue_name = venue_name_in order by concert_date DESC;
end $$

delimiter ;


-- fixes auto_increment to have διαδοχικα person_id
delimiter $$
create procedure fix_person_id()
begin
  declare last_id;

  select count(*) into last_id from person;

  set @sql = concat('ALTER TABLE person AUTO_INCREMENT = ', last_id + 1);
  prepare stmt from @sql;
  execute stmt;
  deallocate prepare stmt;
end $$

delimiter ;