alter database :db1 rename to tmp_db;
alter database :db2 rename to :db1;
alter database tmp_db rename to :db2;

