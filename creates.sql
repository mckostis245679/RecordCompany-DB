 Create database recordlabel;
use recordlabel;


#artst,recordcompany,genre,producer,producercoany,artistcompany,band,person,bandmember, album,  track, albumrelease

CREATE TABLE artist(
  ArtistID INT(11) NOT NULL AUTO_INCREMENT,
  ArtistType   ENUM ('PERSON','BAND','ORCHESTRA','CHOIR','VIRTUAL','OTHER') NOT NULL,
  PRIMARY KEY(ArtistID)
) engine=InnoDB;

CREATE TABLE recordcompany(
  CompanyID INT(11) NOT NULL AUTO_INCREMENT,
  CompanyName VARCHAR(80) DEFAULT 'unknown' NOT NULL,
  Address VARCHAR(150) DEFAULT 'unknown' NOT NULL,
  Phone varchar(20),
  Email varchar(40),
  StartDate date,
  EndDate date,
  PRIMARY KEY(CompanyID)
) engine=InnoDB;

CREATE TABLE genre(
  GenreID INT(11) NOT NULL AUTO_INCREMENT,
  GenreName VARCHAR(30) DEFAULT 'unknown' NOT NULL,
  PRIMARY KEY(GenreID)
) engine=InnoDB;


CREATE TABLE producer(
  ProducerID INT(11) NOT NULL AUTO_INCREMENT,
  FirstName VARCHAR(50) DEFAULT 'unknown' NOT NULL,
  LastName VARCHAR(80) DEFAULT 'unknown' NOT NULL,
  NumofProdAlbums int(11),
  PRIMARY KEY(ProducerID)
) engine=InnoDB;


CREATE TABLE producercompany(
  ProducerID INT(11) NOT NULL AUTO_INCREMENT,
  RecordCompanyID INT(11) NOT NULL ,
  FromDate date NOT NULL,
  ToDate date,
  PRIMARY KEY(ProducerID,RecordCompanyID,FromDate),
  CONSTRAINT RECORD FOREIGN KEY (RecordCompanyID) REFERENCES recordcompany(CompanyID) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PRODUCER FOREIGN KEY (ProducerID) REFERENCES producer(ProducerID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;


CREATE TABLE artistcompany(
  ArtistID INT(11) NOT NULL AUTO_INCREMENT,
  CompanyID INT(11) NOT NULL ,
  FromDate date NOT NULL,
  ToDate date,
  PRIMARY KEY(ArtistID,CompanyID,FromDate),
  CONSTRAINT INRECORD FOREIGN KEY (CompanyID) REFERENCES recordcompany(CompanyID) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT WORKS FOREIGN KEY (ArtistID) REFERENCES artist(ArtistID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;

CREATE TABLE band(
  BandID INT(11) NOT NULL AUTO_INCREMENT,
  BandName VARCHAR(50) DEFAULT 'unknown' NOT NULL,
  FormationDate date ,
  DisbandDate date ,
  ArtistID INT(11) NOT NULL,
  PRIMARY KEY(BandID),
  CONSTRAINT ISARTIST FOREIGN KEY (ArtistID) REFERENCES artist(ArtistID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;

CREATE TABLE person(
  Person_id INT(11) NOT NULL AUTO_INCREMENT,
  FirstName VARCHAR(50) DEFAULT 'unknown' NOT NULL,
  LastName VARCHAR(80) DEFAULT 'unknown' NOT NULL,
  Birthdate date,
  Country varchar(30),
  Alias varchar(30),
  isSoloArtist tinyint(4),
  ArtistID int(11),
  PRIMARY KEY(Person_id),
  CONSTRAINT PERSONARTIST FOREIGN KEY (ArtistID) REFERENCES artist(ArtistID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;


CREATE TABLE bandmember(
   BandID INT(11) NOT NULL AUTO_INCREMENT,
   Person_id INT(11) NOT NULL,
  FromDate date NOT NULL,
  ToDate date,
  PRIMARY KEY(BandID,Person_id,FromDate),
  CONSTRAINT BANDPERSON FOREIGN KEY (Person_id) REFERENCES person(Person_id) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT BANDBAND FOREIGN KEY (BandID) REFERENCES band(BandID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;



CREATE TABLE album(
  AlbumID INT(11) NOT NULL AUTO_INCREMENT,
   ArtistID INT(11) NOT NULL,
   GenreID INT(11) NOT NULL,
   CompanyID INT(11) NOT NULL ,
   ProducerID INT(11) NOT NULL ,
  Title varchar(100) DEFAULT 'unknown' NOT NULL,
  PRIMARY KEY(AlbumID),
  CONSTRAINT ALBUMARTIST FOREIGN KEY (ArtistID) REFERENCES artist(ArtistID) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT ALBUMCOMPANY FOREIGN KEY (CompanyID) REFERENCES recordcompany(CompanyID) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT ALBUMPRODUCER FOREIGN KEY (ProducerID) REFERENCES producer(ProducerID) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT ABLUMGENRE FOREIGN KEY (GenreID) REFERENCES genre(GenreID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;


CREATE TABLE track(
  TrackID INT(11) NOT NULL AUTO_INCREMENT,
   AlbumID INT(11) NOT NULL,
   TrackLength time,
   TrackNo int(11),
   Lyrics text,
  Title varchar(100) DEFAULT 'unknown' NOT NULL,
  PRIMARY KEY(TrackID),
  CONSTRAINT TRACKALBUM FOREIGN KEY (AlbumID) REFERENCES album(AlbumID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;


CREATE TABLE albumrelease(
  ReleaseID INT(11) NOT NULL AUTO_INCREMENT,
  AlbumID INT(11) NOT NULL,
  ReleaseDate date NOT NULL,
  ReleaseType   ENUM ('LP','CD','MP3') NOT NULL,
  ReleaseStatus   ENUM ('OFFICIAL','PROMOTION','BOOTLEG','WITHDRAWN','CANCELED') NOT NULL,
  Packaging   ENUM ('BOOK','CARDBOARD SLEEVE','DIGIPAK','JEWEL CASE','NA') NOT NULL,
  PRIMARY KEY(ReleaseID),
  CONSTRAINT ALBUMALBUM FOREIGN KEY (AlbumID) REFERENCES album(AlbumID) 
  ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;