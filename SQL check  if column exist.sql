
--check  if column exist

--IF EXiST(
IF NOT EXISTS(  
	SELECT * 
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE table_name = N'table_name'
    AND column_name = N'column_name'
		  )
BEGIN
	PRINT(N'Column not exist');
END;
