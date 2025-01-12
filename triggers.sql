-- 3.1.4.1 Trigger after [action] in [table] SAVE IN LOG

-- PERSON

--  insert
delimiter $$
create trigger log_insert_person
after insert on person for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('person', 'INSERT', NOW(), USER());
end $$
delimiter ;

--  delete
delimiter $$
create trigger log_delete_person
after delete on person for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('person', 'DELETE', NOW(), USER());
end $$
delimiter ;

--  update
delimiter $$
create trigger log_update_person
after update on person for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('person', 'UPDATE', NOW(), USER());
end $$
delimiter ;

-- BAND

--  insert
delimiter $$
create trigger log_insert_band
after insert on band for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('band', 'INSERT', NOW(), USER());
end $$
delimiter ;

--  delete
delimiter $$
create trigger log_delete_band
after delete on band for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('band', 'DELETE', NOW(), USER());
end $$
delimiter ;

--  update
delimiter $$
create trigger log_update_band
after update on band for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('band', 'UPDATE', NOW(), USER());
end $$
delimiter ;

-- ALBUM

--  insert
delimiter $$
create trigger log_insert_album
after insert on album for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('album', 'INSERT', NOW(), USER());
end $$
delimiter ;

--  delete
delimiter $$
create trigger log_delete_album
after delete on album for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('album', 'DELETE', NOW(), USER());
end $$
delimiter ;

--  update
delimiter $$
create trigger log_update_album
after update on album for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('album', 'UPDATE', NOW(), USER());
end $$
delimiter ;

-- CONCERT

--  insert
delimiter $$
create trigger log_insert_concert
after insert on concert for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('concert', 'INSERT', NOW(), USER());
end $$
delimiter ;

--  delete
delimiter $$
create trigger log_delete_concert
after delete on concert for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('concert', 'DELETE', NOW(), USER());
end $$
delimiter ;

--  update
delimiter $$
create trigger log_update_concert
after update on concert for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('concert', 'UPDATE', NOW(), USER());
end $$
delimiter ;

-- VENUE

--  insert
delimiter $$
create trigger log_insert_venue
after insert on venue for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('venue', 'INSERT', NOW(), USER());
end $$
delimiter ;

--  delete
delimiter $$
create trigger log_delete_venue
after delete on venue for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('venue', 'DELETE', NOW(), USER());
end $$
delimiter ;

--  update
delimiter $$
create trigger log_update_venue
after update on venue for each row
begin
    insert into log (table_name, action_type, action_time, username)
    values ('venue', 'UPDATE', NOW(), USER());
end $$
delimiter ;


-- 3.1.4.2 TRIGGER prevent invalid date & invalid amount of scheduled concerts
delimiter $$
create trigger prevent_invalid_schedule
before insert on concert
for each row
begin
    declare cnt int;
    if DATEDIFF(NEW.ConcertDate, curdate()) < 5 then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Concert must be scheduled at least 5 days before';
    end if;

    select count(*) into cnt from concert
    where ArtistID = NEW.ArtistID AND ConcertStatus = 'Scheduled';
    if cnt >= 3 then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Artist can have MAX 3 scheduled concerts';
    end if;
end $$
delimiter ;

-- 3.1.4.3 PREVENT invalid update (cancellation or re-schedule)
delimiter $$
create trigger prevent_invalid_update
before update on concert
for each row
begin
    declare cnt int;
    if OLD.ConcertStatus = 'Scheduled' AND NEW.ConcertStatus = 'Canceled' AND
        DATEDIFF(OLD.ConcertDate, curdate()) < 3 then
         SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Concert CANNOT be canceled less than 3 days before';
    end if;

    if OLD.ConcertStatus = 'Canceled' AND NEW.ConcertStatus = 'Scheduled' then
        select count(*) into cnt from concert
        where ArtistID = NEW.ArtistID AND ConcertStatus = 'Scheduled';

        if cnt >= 3 then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Artist has already 3 scheduled concerts';
        end if;
    end if;
end $$   
delimiter ;

-- Move completed or non-rescheduled concerts into concerthistory.
delimiter $$
create trigger concert_to_ConcertHistory
    before update on concert
    for each row
    begin
        if NEW.ConcertStatus = 'Completed' then
            insert into ConcertHistory (concert_id, artist_name, venue_name, ticket_count, concert_date) SELECT
                OLD.ConcertID,
                (SELECT CONCAT(p.FirstName, ' ', p.LastName) from person p where p.ArtistID = OLD.ArtistID LIMIT 1),
                (SELECT v.VenueName from venue v where VenueID = OLD.VenueID LIMIT 1),
                OLD.required_capacity,
                OLD.ConcertDate;
            DELETE from concert where ConcertID = OLD.ConcertID;

        elseif NEW.ConcertStatus = 'Canceled' AND DATEDIFF(OLD.ConcertDate, CURDATE()) <= 3 then
            insert into ConcertHistory (concert_id, artist_name, venue_name, ticket_count, concert_date) SELECT
                OLD.ConcertID,
                (SELECT CONCAT(p.FirstName, ' ', p.LastName) from person p where p.ArtistID = OLD.ArtistID LIMIT 1),
                (SELECT v.VenueName from venue v where VenueID = OLD.VenueID LIMIT 1),
                OLD.required_capacity,
                NULL;
            delete from concert where ConcertID = OLD.ConcertID;
        end if ;
    end $$
delimiter ;




