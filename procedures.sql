


DELIMITER $

CREATE PROCEDURE HasCollaboration(
    IN pID INT(11),
    IN cID INT(11),
    OUT pIsActive INT
)
BEGIN
    DECLARE existsflag INT;
    DECLARE pdate DATE;

    SELECT COUNT(*),MAX(pc.ToDate)
    INTO existsflag, pdate
    FROM producercompany pc
    WHERE pc.ProducerID = pID AND pc.RecordCompanyID = cID;

    IF ((pdate IS NULL OR CURDATE() < pdate )AND  existsflag>0) THEN
        SET pIsActive = 1;
    ELSE 
        SET pIsActive = 0;
    END IF;
END $

DELIMITER ;

DELIMITER $

CREATE TRIGGER CheckCollaboration
BEFORE INSERT ON producercompany
FOR EACH ROW
BEGIN
DECLARE res INT;
CALL HasCollaboration(New.ProducerID,New.RecordCompanyID,res);
IF res=0 THEN  
    SET NEW.FromDate = CURDATE();
ELSE 
    SIGNAL SQLSTATE VALUE '45000'
    SET MESSAGE_TEXT = 'Invalid insertion!!Producer company and record company already collaborating ';
END IF;
END $

DELIMITER ;


INSERT INTO producercompany (ProducerID, RecordCompanyID, FromDate, ToDate) VALUES
(1, 2, '2000-01-01', '2025-12-31');

INSERT INTO producercompany (ProducerID, RecordCompanyID, FromDate, ToDate) VALUES
(4, 5, '2000-01-01',NULL);

INSERT INTO producercompany (ProducerID, RecordCompanyID, FromDate, ToDate) VALUES
(2, 4, '2010-01-01', '2027-12-31');

INSERT INTO producercompany (ProducerID, RecordCompanyID, FromDate, ToDate) VALUES(1, 4, '2020-01-01', '2027-12-31');

DROP PROCEDURE HasCollaboration;
DROP TRIGGER CheckCollaboration;

CALL HasCollaboration(1,2,@res);
SELECT @res;