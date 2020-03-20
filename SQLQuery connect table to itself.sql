CREATE TABLE Employees(
   ID int NOT NULL,
   Name nvarchar(30) NOT NULL,
   ManagerID int,

   CONSTRAINT PK_Employees PRIMARY KEY(ID),
   CONSTRAINT FK_Employees_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employees(ID)
)

INSERT Employees (ID, Name, ManagerID) VALUES
(1000, N'Nick', null),
(1001, N'Mark', 1000),
(1002, N'Ross', 1000),
(1003, N'Sam', 1001)


--simple connection
SELECT a.id AS "Employee ID", a.name AS "Employee Name",
      b.id AS "Manager ID",b.name AS "Manager Name"
FROM Employees a, Employees b
WHERE a.managerId = b.id;


--
SELECT ManagerID, COUNT(ID) as MngCount 
FROM Employees 
GROUP BY ManagerID
HAVING ManagerID IS NOT NULL


-- connect two table 
SELECT e.ID, e.Name, m.EmployeesCount 
FROM Employees e
JOIN (
    SELECT ManagerID, COUNT(ID) as EmployeesCount 
    FROM Employees 
    GROUP BY ManagerID
    HAVING ManagerID IS NOT NULL 
) m 
ON e.Id = m.ManagerID

-- show all rows from table
SELECT e.ID, e.Name, ISNULL(m.EmployeesCount, 0) AS EmployeesCount  
FROM Employees e
LEFT JOIN (
SELECT ManagerID, COUNT(ID) as EmployeesCount 
   FROM Employees 
   GROUP BY ManagerID
   HAVING ManagerID IS NOT NULL 
) m 
ON e.Id = m.ManagerID


-- conditions
SELECT e.ID, e.Name, m.EmployeesCount 
FROM Employees e
JOIN (
   SELECT ManagerID, COUNT(ID) as EmployeesCount 
   FROM Employees 
   GROUP BY ManagerID
   HAVING ManagerID IS NOT NULL 
   --AND COUNT(ID) > 1 -- +++
) m 
ON e.Id = m.ManagerID
WHERE m.EmployeesCount > 1 -- ++++
