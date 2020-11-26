CREATE TABLE contacts(
    contact_id INT IDENTITY(1,1) NOT NULL,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,

	CONSTRAINT PK_Contacts PRIMARY KEY(contact_id),
);

INSERT INTO contacts
    (first_name,last_name,email) 
VALUES
    ('Syed','Abbas','syed.abbas@example.com'),
    ('Catherine','Abel','catherine.abel@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Pilar','Ackerman','pilar.ackerman@example.com');


SELECT *
FROM contacts

SELECT *
FROM contacts
ORDER BY contact_id -- ofset can be used only with order by
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;
