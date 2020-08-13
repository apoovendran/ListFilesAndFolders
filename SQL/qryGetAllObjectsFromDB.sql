/*
AllObjectsFromDB
https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-all-objects-transact-sql?view=sql-server-ver15

SELECT *
FROM sys.objects
*/




select 
	@@Servername As ServerName, 
	DB_NAME() As DatabaseName,
	SCHEMA_NAME(schema_id) as SchemaName,
	type_desc as ObjType,
	name as ObjectName
 from sys.all_objects 
 where 
 --name = 'dt_checkoutobject_u' and 
 is_ms_shipped = 0 
 and name <> ('chaintrace')
 and name not like 'dt_%'
 order by type, name
