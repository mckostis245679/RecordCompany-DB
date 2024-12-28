-- 3.1.3.1 calculate venue score

delimiter $$

create procedure CalcVenueScore (IN venueID, OUT score int)
begin
  select (Capacity / 1000) + (NumofConcerts / 100) * 3 + (OperationYears * 2) into score
  from venue 
  where VenueID = venueID;
end $$

delimiter ;


-- 3.1.3.2 concert management

delimiter $$

create procedure manageconcert (IN artist_ID_in INT, IN concert_date_in DATE, IN action_type_in CHAR(1))
begin
  declare scheduled_cnt int;
  declare msg_out varchar(100);

-- check scheduled concerts
  select count(*) into scheduled_count from concert
  where ArtistID = artist_ID_in and ConcertStatus = 'Scheduled';

  case action_type
    when 'i' then
      if scheduled_cnt >= 3 then
        SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT = 'Artist has already 3 scheduled concerts';
      elseif datediff(concert_date_in, curdate()) < 5 then
        SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT = 'Concert must be scheduled at least 5 days in advance';
      else
        insert into Concert (ArtistID, concert_date) values (artist_ID_in, concert_date_in);
        set msg_out = 'Concert scheduled.';
      end if;

    when 'c' then
      if datediff(concert_date_in, curdate()) < 3 then
        SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT = 'Cannot cancel concert 3 days before';
      else 
        update concert set ConcertStatus 'Cancelled'
        where ArtistID = artist_ID_in AND concert_date = concert_date_in AND ConcertStatus = 'Scheduled';
        set msg_out = 'Concert cancelled.';
      end if;
    
    when 'a' then
      if scheduled_cnt >= 3 then
        SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT = 'Artist has already 3 scheduled concerts';
      else 
        update concert set ConcertStatus = 'Scheduled'
        where ArtistID = artist_ID_in AND concert_date = concert_date_in AND ConcertStatus = 'Cancelled';
        set msg_out = 'Concert reactivated.';
      end if;
   end case;

   select msg_out as message;

end $$

delimiter ;

-- 3.1.3.3 Find venue
delimiter $$

create procedure FindVenue (IN concert_id_in INT, IN req_capacity_in INT, OUT selected_venue_id INT, OUT selected_capacity INT)
begin
  declare concert_status varchar(20);

  select ConcertStatus into concert_status from Concert
  where ConcertID = concert_id_in;

  if concert_status = 'Cancelled' OR concert_status is null then
    set selected_venue_id = NULL;
    set selected_capacity = 0;
  else
    select venueID, Capacity into selected_venue_id, selected_capacity from venue
    where Capacity >= (1.1 * req_capacity_in) AND VenueID NOT IN (select venueID from Concert where ConcertStatus = 'Scheduled')
    order by rating DESC limit 1;
  end if;
end $$

delimiter ;


-- INDEXES for procedure optimization

create index concert_status_idx on Concert(ConcertStatus);
create index concert_date_idx on Concert(ConcertDate);
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

create procedure Find_COncert_byVenue(IN venue_name_in varchar(100))
begin
  select concert_date from ConcertHistory
  where venue_name = venue_name_in order by concert_date DESC;
end $$

delimiter ;
