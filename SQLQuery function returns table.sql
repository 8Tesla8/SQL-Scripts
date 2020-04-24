CREATE TABLE Professions (
	ProfessionId INT NOT NULL,
	ProfessionName NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_Professions PRIMARY KEY (ProfessionId)
);


CREATE TABLE Projects (
	ProjectId INT NOT NULL,
	ProjectName NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_Projects PRIMARY KEY (ProjectId),
);


CREATE TABLE Employees (
	EmployeeId INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	ProfessionId INT NOT NULL,
	ProjectId INT NOT NULL,

	CONSTRAINT PK_Employees PRIMARY KEY (EmployeeId),
	CONSTRAINT FK_EmployeesProfessions FOREIGN KEY (ProfessionId) REFERENCES Professions(ProfessionId),
	CONSTRAINT FK_EmployeesProjects FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectId)
);


--
INSERT INTO Professions
(ProfessionId, ProfessionName)
VALUES
(1, 'Developer'),
(2, 'PM'),
(3, 'HR');

INSERT INTO Projects
(ProjectId, ProjectName)
VALUES
(1, 'CMS'),
(2, 'Company T');

INSERT INTO Employees 
(EmployeeId, FirstName, ProfessionId, ProjectId)
VALUES
(1, 'Nick', 2, 1),
(2, 'Kira', 3, 2),
(3, 'Jack', 1, 1),
(4, 'Denis', 1, 1);

--
CREATE FUNCTION [dbo].[GetEmployeeInformation] 
	(@employeeId INTEGER) 
RETURNS TABLE
AS
RETURN
	SELECT p.ProfessionName, pr.ProjectName
	FROM Employees e
		JOIN Professions p ON p.ProfessionId = e.ProfessionId
		JOIN Projects pr ON pr.ProjectId = e.ProjectId
	WHERE e.EmployeeId = @employeeId
--GO
--
SELECT * FROM GetEmployeeInformation(2);

-- 
SELECT e.FirstName, ei.ProfessionName, ei.ProjectName
FROM Employees e
CROSS APPLY GetEmployeeInformation(e.EmployeeId) ei


