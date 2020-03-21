CREATE TABLE Account(
	ID int NOT NULL,
	Name nvarchar(30) NOT NULL,
	Money int NOT NULL

	CONSTRAINT PK_Account PRIMARY KEY(ID),
)

INSERT Account (ID, Name, Money) VALUES
(1, 'Nick', 1000),
(2, 'Mark', 800),
(3, 'John', 400),
(4, 'Marta', 600),
(5, 'Igor', 200)


CREATE TABLE SpendMoney (
	AccountId int NOT NULL,
	Money  int NOT NULL,

	CONSTRAINT FK_SpendMoney_AccountID FOREIGN KEY (AccountId) REFERENCES Account(ID)
)

INSERT SpendMoney (AccountId, Money) VALUES
(1, 2000),
(3, 400),
(5, 500)

--
SELECT a.ID, a.Name, a.Money as BankMoney, ISNULL(sm.Money, 0) as SpendMoney, a.Money + ISNULL(sm.Money, 0) as Sum
--, a.Money + sm.Money as WrongSum -- will be null because left join and SpendMoney don't have all data from Account
FROM Account a
LEFT JOIN SpendMoney sm on a.ID = sm.AccountId
