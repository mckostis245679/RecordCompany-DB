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
      end if;

    when 'c' then
      if datediff(concert_date_in, curdate()) < 3 then
        SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT = 'Cannot cancel concert 3 days before';
      else 
        update concert set ConcertStatus 'Cancelled'
        where ArtistID = artist_ID_in AND concert_date = concert_date_in AND ConcertStatus = 'Scheduled';
      end if;
    
    when 'a' then
      if scheduled_cnt >= 3 then
        SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT = 'Artist has already 3 scheduled concerts';
      else 
        update concert set ConcertStatus = 'Scheduled'
        where ArtistID 