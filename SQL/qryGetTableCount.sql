----Sql 2005 OR After 
CREATE TABLE #counts
(
    table_name varchar(255),
    row_count int
)

EXEC sp_MSForEachTable @command1='INSERT #counts (table_name, row_count) SELECT ''?'', COUNT(*) FROM ?'
SELECT table_name, row_count FROM #counts ORDER BY table_name, row_count DESC
DROP TABLE #counts

--------SQL SERVER 2000
declare c_tables cursor fast_forward for
select table_name from information_schema.tables

open c_tables
declare @tablename varchar(255)
declare @stmt nvarchar(2000)
declare @rowcount int
fetch next from c_tables into @tablename

while @@fetch_status = 0
begin

    select @stmt = 'select @rowcount = count(*) from ' + @tablename

    exec sp_executesql @stmt, N'@rowcount int output', @rowcount=@rowcount OUTPUT

    print N'table:,' + @tablename + ',' + convert(nvarchar(1000),@rowcount) 

    fetch next from c_tables into @tablename

end

close c_tables
deallocate c_tables