select * from INFORMATION_SCHEMA.tables  where table_name like '%state%'

select * from Philly01.dbo.z2t_PublishedTables


EXEC sp_tables_ex 'Philly01', 'z2t_PublishedTables','TABLE'
@table_server = 'your_linked_server_name',
3.
@table_catalog = 'your_database',
4.
@table_type = 'TABLE'