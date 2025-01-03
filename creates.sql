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
    rating         decimal(4, 2) as ((((`Capacity` / 1000) + ((`NumofConcerts` / 100) * 3)) + (`OperationYears` * 2)))
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
    history_id int primary key AUTO_INCREMENT,
    concert_id int not null,
    artist_name varchar(50) not null,
    venue_name varchar(100) not null,
    ticket_count int,
    concert_date date
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

/*
 Για τους Διαχειριστές Βάσης Δεδομένων (DBA) τηρείται
η ημερομηνία που ανέλαβαν το ρόλο (start_date), η οποία δεν μπορεί να
είναι null. Επίσης υπάρχει end_date ημερομηνία για όσους DBA έχουν φύγει
από τη θέση. Μπορεί να υπάρχουν περισσότεροι από ένας Διαχειριστές
Βάσης Δεδομένων την ίδια χρονική περίοδο. Οι ενέργειες των Διαχειριστών
Βάσης Δεδομένων καταγράφοντα σε έναν πίνακα log όπως περιγράφεται
στο Ερώτημα 3.1.4.1.

Trigger που θα ενημερώνουν το σχετικό πίνακα καταγραφής ενεργειών
(log) για κάθε ενέργεια εισαγωγής, ενημέρωσης ή διαγραφής στους πίνακες
person, band, album, concert, venue με την ημερομηνία και ώρα και το
username του DBA που την εκτέλεσε.


USER()
 */