INSERT INTO genre (GenreName) VALUES 
('Pop Rock'),
('Hip Hop'),
('R&B'),
('Alternative Rock'),
('Electronic Pop');

INSERT INTO recordcompany (CompanyName, Address, Phone, Email, BeginDate) VALUES
('Universal Music Group', '2220 Colorado Avenue, Santa Monica, CA', '818-877-2222', 'contact@universalmusic.com', '1934-01-01'),
('Sony Music Entertainment', '25 Madison Avenue, New York, NY', '212-833-8000', 'contact@sonymusic.com', '1929-01-01'),
('Warner Music Group', '1633 Broadway, New York, NY', '212-275-2000', 'contact@wmg.com', '1958-03-19'),
('Columbia Records', '550 Madison Avenue, New York, NY', '212-833-8000', 'contact@columbiarecords.com', '1889-01-01'),
('Republic Records', '1755 Broadway, New York, NY', '212-373-0800', 'contact@republicrecords.com', '1995-01-01');


INSERT INTO producer (FirstName, LastName, NumOfProdAlbums) VALUES
('Max', 'Martin', 50),
('Rick', 'Rubin', 45),
('Quincy', 'Jones', 40),
('Finneas', 'OConnell', 15),
('Jack', 'Antonoff', 25),
('Mark', 'Ronson', 20);

INSERT INTO artist (ArtistType) VALUES
('PERSON'),     -- Taylor Swift
('PERSON'),     -- Ed Sheeran
('BAND'),       -- Coldplay
('BAND'),       -- Imagine Dragons
('ORCHESTRA'),  -- London Symphony Orchestra
('CHOIR'),      -- London Symphony Chorus
('PERSON'),     -- Adele
('BAND'),       -- The Weeknd
('VIRTUAL'),    -- Gorillaz
('PERSON');     -- Billie Eilish


INSERT INTO person (FirstName, LastName, Birthdate, Country, ArtistID) VALUES
('Taylor', 'Swift', '1989-12-13', 'USA', 1),
('Ed', 'Sheeran', '1991-02-17', 'UK', 2),
('Chris', 'Martin', '1977-03-02', 'UK', NULL),
('Dan', 'Reynolds', '1987-07-14', 'USA', NULL),
('Adele', 'Adkins', '1988-05-05', 'UK', 7),
('Abel', 'Tesfaye', '1990-02-16', 'Canada', 8),
('Billie', 'Eilish', '2001-12-18', 'USA', 10);


INSERT INTO band (BandName, FormationDate, ArtistID) VALUES
('Coldplay', '1996-09-01', 3),
('Imagine Dragons', '2008-01-01', 4),
('Gorillaz', '1998-01-01', 9);


INSERT INTO bandmember (BandID, PersonID, FromDate) VALUES
(1, 3, '1996-09-01'),    -- Chris Martin in Coldplay
(2, 4, '2008-01-01'),    -- Dan Reynolds in Imagine Dragons
(1, 5, '1996-09-01'),    -- Jonny Buckland in Coldplay
(2, 6, '2008-01-01');    -- Wayne Sermon in Imagine Dragons


INSERT INTO artistcompany (ArtistID, CompanyID, FromDate) VALUES
(1, 1, '2006-01-01'),  -- Taylor Swift - Universal
(2, 2, '2011-01-01'),  -- Ed Sheeran - Sony
(3, 3, '2000-01-01'),  -- Coldplay - Warner
(4, 4, '2012-01-01'),  -- Imagine Dragons - Columbia
(5, 1, '1990-01-01'),  -- LSO - Universal
(6, 1, '1990-01-01'),  -- LSC - Universal
(7, 2, '2008-01-01'),  -- Adele - Sony
(8, 5, '2012-01-01'),  -- The Weeknd - Republic
(9, 3, '2001-01-01'),  -- Gorillaz - Warner
(10, 5, '2016-01-01'), -- Billie Eilish - Republic
(1, 5, '2018-01-01');  -- Taylor Swift - Republic (second contract)


INSERT INTO producercompany (ProducerID, RecordCompanyID, FromDate) VALUES
(1, 1, '2000-01-01'),  -- Max Martin - Universal
(2, 2, '1990-01-01'),  -- Rick Rubin - Sony
(3, 3, '1980-01-01'),  -- Quincy Jones - Warner
(4, 5, '2016-01-01'),  -- Finneas - Republic
(5, 2, '2010-01-01'),  -- Jack Antonoff - Sony
(6, 1, '2005-01-01'),  -- Mark Ronson - Universal
(1, 5, '2015-01-01'),  -- Max Martin - Republic
(2, 3, '2000-01-01');  -- Rick Rubin - Warner

-- Album (minimum 10)
INSERT INTO album (Title, ArtistID, GenreID, CompanyID, ProducerID) VALUES
('1989', 1, 1, 1, 1),                    -- Taylor Swift
('÷ (Divide)', 2, 1, 2, 2),              -- Ed Sheeran
('Music of the Spheres', 3, 4, 3, 3),    -- Coldplay
('Mercury - Act 1', 4, 4, 4, 2),         -- Imagine Dragons
('Classical Collection', 5, 4, 1, 3),     -- LSO
('Choral Classics', 6, 4, 1, 3),         -- LSC
('30', 7, 3, 2, 5),                      -- Adele
('After Hours', 8, 3, 5, 1),             -- The Weeknd
('Demon Days', 9, 5, 3, 6),              -- Gorillaz
('Happier Than Ever', 10, 1, 5, 4);      -- Billie Eilish

-- Track (minimum 25)
INSERT INTO track (Title, AlbumID, TrackLength, TrackNo) VALUES
-- 1989 tracks
('Shake It Off', 1, '00:03:39', 1),
('Blank Space', 1, '00:03:51', 2),
('Style', 1, '00:03:51', 3),
-- ÷ (Divide) tracks
('Shape of You', 2, '00:03:53', 1),
('Castle on the Hill', 2, '00:04:21', 2),
-- Music of the Spheres tracks
('Higher Power', 3, '00:03:26', 1),
('My Universe', 3, '00:03:46', 2),
('Coloratura', 3, '00:10:18', 3),
-- Mercury - Act 1 tracks
('Enemy', 4, '00:02:53', 1),
('Wrecked', 4, '00:03:54', 2),
-- Classical Collection tracks
('Symphony No. 5', 5, '00:07:15', 1),
('Piano Concerto No. 21', 5, '00:05:50', 2),
('Violin Concerto in D', 5, '00:06:30', 3),
-- Choral Classics tracks
('Hallelujah', 6, '00:04:30', 1),
('Ave Maria', 6, '00:05:20', 2),
-- 30 tracks
('Easy On Me', 7, '00:03:44', 1),
('Oh My God', 7, '00:03:45', 2),
('I Drink Wine', 7, '00:06:16', 3),
-- After Hours tracks
('Blinding Lights', 8, '00:03:20', 1),
('Save Your Tears', 8, '00:03:35', 2),
-- Demon Days tracks
('Feel Good Inc', 9, '00:03:41', 1),
('DARE', 9, '00:04:04', 2),
-- Happier Than Ever tracks
('Therefore I Am', 10, '00:02:54', 1),
('Your Power', 10, '00:04:05', 2),
('Happier Than Ever', 10, '00:04:58', 3);

-- AlbumRelease (minimum 12)
INSERT INTO albumrelease (AlbumID, ReleaseDate, ReleaseType, ReleaseStatus, Packaging) VALUES
(1, '2014-10-27', 'CD', 'OFFICIAL', 'JEWEL CASE'),      -- 1989 CD
(1, '2014-10-27', 'LP', 'OFFICIAL', 'CARDBOARD SLEEVE'), -- 1989 Vinyl
(2, '2017-03-03', 'CD', 'OFFICIAL', 'DIGIPAK'),         -- ÷ (Divide)
(3, '2021-10-15', 'CD', 'OFFICIAL', 'DIGIPAK'),         -- Music of the Spheres
(4, '2021-09-03', 'CD', 'OFFICIAL', 'JEWEL CASE'),      -- Mercury - Act 1
(5, '2020-01-15', 'CD', 'OFFICIAL', 'BOOK'),            -- Classical Collection
(6, '2020-02-20', 'CD', 'OFFICIAL', 'BOOK'),            -- Choral Classics
(7, '2021-11-19', 'CD', 'OFFICIAL', 'DIGIPAK'),         -- 30
(8, '2020-03-20', 'CD', 'OFFICIAL', 'JEWEL CASE'),      -- After Hours
(9, '2005-05-11', 'CD', 'OFFICIAL', 'JEWEL CASE'),      -- Demon Days
(10, '2021-07-30', 'CD', 'OFFICIAL', 'DIGIPAK'),        -- Happier Than Ever
(10, '2021-07-30', 'LP', 'OFFICIAL', 'CARDBOARD SLEEVE'); -- Happier Than Ever Vinyl

-- Venue
insert into venue (VenueID, VenueName, Venue_Location, Opening_Date, Capacity, NumofConcerts, OperationYears, rating) values
(1, 'Madison Square Garden', 'New York, USA', '1990-01-01', 20000, 300, 35, 99.00),
(2, 'O2 Arena', 'London, UK', '1995-01-01', 20000, 400, 30, 92.00),
(3, 'Sydney Opera House', 'Sydney, Australia', '1973-10-20', 5733, 150, 51, 112.23),
(4, 'Royal Albert Hall', 'London, UK', '1871-03-29', 5272, 500, 154, 328.27),
(5, 'Hollywood Bowl', 'Los Angeles, USA', '1922-07-11', 17500, 350, 103, 234.00),
(6, 'Wembley Stadium', 'London, UK', '1923-04-28', 90000, 200, 102, 300.00),
(7, 'Staples Center', 'Los Angeles, USA', '1999-10-17', 20000, 300, 25, 79.00),
(8, 'Tokyo Dome', 'Tokyo, Japan', '1988-03-17', 55000, 400, 37, 141.00),
(9, 'Mercedes-Benz Arena', 'Berlin, Germany', '2008-09-12', 17000, 150, 16, 53.50),
(10, 'Scotiabank Arena', 'Toronto, Canada', '1999-02-19', 19000, 250, 26, 78.50);

-- DBA
insert into DBA (username, start_date, end_date) values
(USER(), CURDATE(), NULL);
