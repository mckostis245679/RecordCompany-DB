create table venue
(
    VenueID        int auto_increment
        primary key,
    VenueName      varchar(100)  not null,
    Venue_Location varchar(200)  not null,
    Opening_Date   date          not null,
    Capacity       int           not null,
    NumofConcerts  int default 0 null,
    OperationYears int default 0 null,
    rating         decimal(8, 2) default null
);

CREATE TABLE concert (
    ConcertID int(11) AUTO_INCREMENT PRIMARY KEY,
    ConcertStatus ENUM('Scheduled', 'Completed', 'Canceled') NOT NULL,
    ConcertDate date not null ,
    required_capacity int not null,
    ArtistID int(11) not null,
    VenueID int(11) not null,

    CONSTRAINT HASARTIST FOREIGN KEY (ArtistID) REFERENCES artist(ArtistID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT HASVENUE FOREIGN KEY (VenueID) REFERENCES venue(VenueID)
    ON UPDATE CASCADE ON DELETE CASCADE
);


create table ConcertHistory (
    concert_id int not null AUTO_INCREMENT,
    artist_name varchar(50) not null,
    venue_name varchar(100) not null,
    ticket_count int,
    concert_date date,
    primary key (concert_id)
);



CREATE TABLE DBA (
    username varchar(100) not null unique,
    start_date date not null,
    end_date date ,
    PRIMARY KEY(username)
);

CREATE TABLE log (
    log_id INT AUTO_INCREMENT NOT NULL primary key,
    table_name VARCHAR(50) NOT NULL,
    action_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    action_time DATETIME NOT NULL, 
    username VARCHAR(100) NOT NULL,
    CONSTRAINT HAS_USER FOREIGN KEY (username) REFERENCES DBA(username)
    ON UPDATE CASCADE ON DELETE CASCADE
);