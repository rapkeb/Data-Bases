CREATE VIEW ConstructionEmployeeOverFifty AS
SELECT Employee.EID, Employee.FirstName,Employee.LastName,Employee.BirthDate,Employee.Door,Employee.Number,Employee.StreetName,Employee.City,ConstructorEmployee.CompanyName,ConstructorEmployee.SalaryPerDay
FROM Employee  JOIN ConstructorEmployee
ON Employee.EID=ConstructorEmployee.EID
WHERE strftime('%Y-%m-%d', DATE('now'))-Employee.BirthDate>=50
;
CREATE VIEW ApartmentNumberInNeighborhood AS
SELECT NID, count(NID) AS ApartmentNumber FROM Apartment
GROUP BY NID
;
CREATE TRIGGER DeleteProject 
BEFORE
DELETE
ON Project
FOR EACH ROW
BEGIN
		DELETE FROM ProjectConstructorEmployee
		WHERE PID=old.PID;
		DELETE FROM ConstructorEmployee
		WHERE EID NOT IN (SELECT DISTINCT EID FROM ProjectConstructorEmployee);
		DELETE FROM Employee
		WHERE EID NOT IN (SELECT* FROM(SELECT EID FROM ConstructorEmployee UNION SELECT EID FROM OfficialEmployee));
END;
;

CREATE TRIGGER ManageTwoDepInsert
BEFORE
INSERT
ON Department
FOR EACH ROW
BEGIN
	SELECT RAISE(ABORT, 'There can be only two.')
    WHERE EXISTS (SELECT *
                  FROM (SELECT ManagerID, count(DID) as c
						FROM Department
						where ManagerID=new.ManagerID) as T
                  WHERE T.c >=2);
END;

CREATE TRIGGER ManageTwoDepUpdate
BEFORE
UPDATE
ON Department
FOR EACH ROW
BEGIN
	SELECT RAISE(ABORT, 'There can be only two.')
    WHERE EXISTS (SELECT *
                  FROM (SELECT ManagerID, count(DID) as c
						FROM Department
						where ManagerID=new.ManagerID) as T
                  WHERE T.c >=2);
END;

CREATE TRIGGER DeleteNonWorking
BEFORE
DELETE
ON ProjectConstructorEmployee
FOR EACH ROW
BEGIN
		DELETE FROM ConstructorEmployee
		WHERE (SELECT count(PID) as c
					  FROM (SELECT *
							FROM ProjectConstructorEmployee
						    WHERE EID=new.EID) as T
				WHERE T.c=0) AND EID=new.EID;
END;
;