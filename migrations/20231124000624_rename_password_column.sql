-- migrations/20231124000624_rename_password_column.sql

ALTER TABLE users RENAME
password TO password_hash;
