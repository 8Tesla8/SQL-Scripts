--remove constraint on default value without name

--drop constraint on default value
DECLARE @default SYSNAME, @sql NVARCHAR(MAX)

-- get name of constraint for default value
SELECT @default = NAME 
FROM sys.default_constraints 
WHERE parent_object_id = object_id(N'Table_Name') 
AND TYPE = 'D'
AND parent_column_id = (
    SELECT column_id 
	FROM sys.columns 
    WHERE object_id = object_id(N'Table_Name') 
	AND NAME = N'Column_Name' 
)

-- remove constraint for default value
IF @default IS NOT NULL 
BEGIN
	SET @sql = N'ALTER TABLE Table_Name DROP CONSTRAINT ' + @default
	EXEC sp_executesql @sql
END


--check  if column exist
