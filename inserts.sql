artst 10,recordcompany 5,genre 5,producer 6,producercoany 8,artistcompany 11,band 3,person 7,bandmember 4, album 10,  track 25, albumrelease 12

INSERT INTO artist (ArtistType) VALUES
('PERSON'),
('BAND'),
('ORCHESTRA'),
('CHOIR'),
('VIRTUAL'),
('OTHER'),
('PERSON'),
('BAND'),
('CHOIR'),
('VIRTUAL');

INSERT INTO recordcompany (CompanyName, Address, Phone, Email, StartDate, EndDate) VALUES
('Columbia Records', '30 Rockefeller Plaza, New York, NY 10112',  '7184455667', 'columbia@columbiarecords.com', '1888-10-01', NULL),
('Capitol Records', '1750 N Vine St, Los Angeles, CA 90028',  '3235567788', 'capitol@capitolrecords.com', '1942-06-15', '2018-01-01'),
('Motown Records', '2648 W Grand Blvd, Detroit, MI 48208',  '3136678899', 'motown@motownrecords.com', '1959-01-12', NULL),
('Atlantic Records', '1290 Avenue of the Americas, New York, NY 10104',  '2233445566', 'atlantic@atlanticrecords.com', '1947-10-01', NULL),
('Def Jam Recordings', '1755 Broadway, New York, NY 10019',  '3344556677', 'info@defjam.com', '1984-11-01', NULL);

INSERT INTO genre (GenreName) VALUES
('Rock'),
('Pop'),
('Jazz'),
('Classical'),
('Hip-Hop');

INSERT INTO producer (FirstName, LastName, NumofProdAlbums) VALUES
('Quincy', 'Jones', 50),
('Max', 'Martin', 23),
('Rick', 'Rubin', 30),
('Timbaland', 'Mosley', 45),
('Dr.', 'Dre', 28),
('George', 'Martin', 40);

INSERT INTO producercompany (ProducerID, RecordCompanyID, FromDate, ToDate) VALUES
(1, 2, '2000-01-01', '2005-12-31'),
(2, 3, '2005-01-01', NULL),
(3, 1, '2010-05-15', '2015-08-30'),
(4, 4, '2012-02-01', '2018-10-01'),
(5, 5, '2015-03-01', NULL),
(6, 4, '1990-06-20', '2000-12-31'),
(3, 2, '2008-07-01', '2013-11-15'),
(1, 4, '2017-04-01', NULL),
(6, 2, '2000-01-01', '2025-12-31');


INSERT INTO artistcompany (ArtistID, CompanyID, FromDate, ToDate) VALUES
(1, 2, '2000-01-01', '2005-12-31'),
(2, 3, '2005-01-01', NULL),
(3, 1, '2010-05-15', '2015-08-30'),
(4, 4, '2012-02-01', '2018-10-01'),
(5, 5, '2015-03-01', NULL),
(6, 2, '1990-06-20', '2000-12-31'),
(7, 2, '2008-07-01', '2013-11-15'),
(8, 4, '2017-04-01', NULL),
(9, 1, '2003-06-15', '2009-09-30'),
(10, 3, '2007-11-01', NULL),
(1, 1, '1995-01-01', '2005-12-31');

INSERT INTO band (BandName, FormationDate, DisbandDate, ArtistID) VALUES
('The Beatles', '1960-08-01', '1970-04-10', 1),
('Queen', '1970-03-01', NULL, 2),
('The Rolling Stones', '1962-07-12', NULL, 3);

INSERT INTO person (FirstName, LastName, Birthdate, Country, Alias, isSoloArtist, ArtistID) VALUES
('John', 'Lennon', '1940-10-09', 'United Kingdom', 'Lennon', 1, 1),
('Paul', 'McCartney', '1942-06-18', 'United Kingdom', 'McCartney', 1, 1),
('George', 'Harrison', '1943-02-25', 'United Kingdom', 'Harrison', 1, 1),
('Ringo', 'Starr', '1940-07-07', 'United Kingdom', 'Starr', 1, 1),
('Freddie', 'Mercury', '1946-09-05', 'United Kingdom', 'Mercury', 1, 2),
('Brian', 'May', '1947-07-19', 'United Kingdom', 'May', 1, 2),
('Mick', 'Jagger', '1943-07-26', 'United Kingdom', 'Jagger', 0, 3);


INSERT INTO bandmember (BandID, Person_id, FromDate, ToDate) VALUES
(1, 1, '1960-08-01', '1970-04-10'),
(1, 2, '1960-08-01', '1970-04-10'),
(2, 5, '1970-03-01', NULL),
(3, 7, '1962-07-12', NULL);

INSERT INTO album (AlbumID,ArtistID, GenreID, CompanyID, ProducerID, Title) VALUES
(1,1, 1, 1, 1, 'Thriller'),
(2,2, 2, 2, 2, 'Back to Black'),
(3,3, 3, 3, 3, 'Rumors'),
(4,4, 3, 4, 4, 'Nevermind'),
(5,5, 5, 5, 5, 'Abbey Road'),
(6,6, 1, 1, 6, 'The Dark Side of the Moon'),
(7,7, 2, 2, 1, 'The Miseducation of Lauryn Hill'),
(8,8, 3, 3, 2, 'A Night at the Opera'),
(9,9, 4, 4, 3, 'Abbey Road'),
(10,10, 5, 5, 4, 'Born to Run');

INSERT INTO track (AlbumID, TrackLength, TrackNo, Lyrics, Title) VALUES
(1, '00:04:54', 2, 'For forty days and for forty nights, law was on her side', 'Beat It'),
(1, '00:04:35', 4, 'And shes laying away', 'PYT (Pretty Young Thing)'),
(1, '00:05:19', 5, 'Show you the world', 'The Girl Is Mine'),
(2, '00:04:02', 1, 'He left no time to regret', 'Rehab'),
(2, '00:03:05', 2, 'We only said goodbye with words', 'Back to Black'),
(3, '00:04:19', 1, 'You know that I love you', 'Go Your Own Way'),
(3, '00:02:33', 4, 'Tell me lies, tell me sweet little lies', 'Little Lies'),
(3, '00:03:33', 5, 'Say you love me', 'Everywhere'),
(4, '00:03:38', 1, 'Load up on guns, bring your friends', 'Smells Like Teen Spirit'),
(4, '00:03:18', 5, 'Just because you re paranoid', 'Breed'),
(5, '00:02:45', 4, 'You never give me your money', 'You Never Give Me Your Money'),
(5, '00:04:00', 5, 'Golden slumbers fill your eyes', 'Golden Slumbers'),
(6, '00:03:43', 1, 'Breathe, breathe in the air', 'Breathe'),
(6, '00:03:34', 2, 'Dont be afraid to care', 'Time'),
(6, '00:06:53', 3, 'All that s necessary', 'Money'),
(6, '00:03:29', 4, 'Run, rabbit, run', 'Us and Them'),
(6, '00:06:31', 5, 'For long you live and high you fly', 'Brain Damage'),
(7, '00:03:23', 1, 'Strumming my pain with his fingers', 'Killing Me Softly with His Song'),
(7, '00:04:29', 2, 'Singing my life with his words', 'The Miseducation of Lauryn Hill'),
(8, '00:04:55', 1, 'Can you find me somebody to love?', 'Somebody to Love'),
(8, '00:03:04', 2, 'Oh, baby, cant do this to me, baby!', 'Crazy Little Thing Called Love'),
(8, '00:03:12', 3, 'I sometimes wish I d never been born at all', 'Bohemian Rhapsody'),
(9, '00:03:40', 1, 'Hey, hey, hey, hey', 'Seven Days'),
(9, '00:03:29', 2, 'Now I believe in yesterday', 'Sundays'),
(10, '00:03:28', 1, 'Once upon a time not so long ago', 'Born to Run');



INSERT INTO albumrelease (AlbumID, ReleaseDate, ReleaseType, ReleaseStatus, Packaging) VALUES
(1, '1965-08-06', 'LP', 'OFFICIAL', 'BOOK'),
(1, '1965-08-06', 'CD', 'PROMOTION', 'CARDBOARD SLEEVE'),
(2, '1975-11-21', 'LP', 'BOOTLEG', 'DIGIPAK'),
(2, '1975-11-21', 'CD', 'OFFICIAL', 'JEWEL CASE'),
(3, '1971-04-23', 'MP3', 'CANCELED', 'NA'),
(3, '1971-04-23', 'LP', 'OFFICIAL', 'CARDBOARD SLEEVE'),
(4, '1979-07-27', 'CD', 'PROMOTION', 'DIGIPAK'),
(4, '1979-07-27', 'LP', 'OFFICIAL', 'JEWEL CASE'),
(5, '1969-09-26', 'LP', 'WITHDRAWN', 'NA'),
(5, '1969-09-26', 'CD', 'OFFICIAL', 'BOOK'),
(6, '1967-05-26', 'LP', 'OFFICIAL', 'JEWEL CASE'),
(6, '1967-05-26', 'CD', 'PROMOTION', 'CARDBOARD SLEEVE');


