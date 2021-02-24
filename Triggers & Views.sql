CREATE VIEW ConstructionEmployeeOverFifty As
SELECT Employee.*,ConstructorEmployee.CompanyName,ConstructorEmployee.SalaryPerDay
from Employee JOIN ConstructorEmployee
ON ConstructorEmployee.EID = Employee.EID
WHERE Employee.BirthDate <=  datetime('now','-50 years')
;

CREATE VIEW ApartmentNumberInNeighborhood AS
Select Neighborhood.NId,count(Neighborhood.NID) from
Neighborhood Join Apartment On Neighborhood.NID=Apartment.NID
Group By Neighborhood.NID
;

-- Add Triggers Here, do not forget to separate the triggers with ;

CREATE TRIGGER DeleteProject
BEFORE DELETE on Project
BEGIN
DELETE from ProjectConstructorEmployee
WHERE (old.PID = PID);
DELETE FROM ConstructorEmployee
WHERE ConstructorEmployee.EID NOT IN (SELECT EID FROM ProjectConstructorEmployee);
DELETE FROM Employee
WHERE Employee.EID NOT IN (SELECT EID FROM ConstructorEmployee);
END;
;
CREATE TRIGGER LimitManage BEFORE INSERT on Department
FOR EACH ROW
BEGIN
		SELECT RAISE (ABORT,'cannot manage')
		WHERE (SELECT count(ManagerID) FROM Department where new.ManagerID = Department.ManagerID) >= 2;
		END;
;
CREATE TRIGGER LimitManage1 BEFORE UPDATE on Department
FOR EACH ROW
BEGIN
		SELECT RAISE (ABORT,'cannot manage')
		WHERE (SELECT count(ManagerID) FROM Department where new.ManagerID = Department.ManagerID) >= 2;
		END;