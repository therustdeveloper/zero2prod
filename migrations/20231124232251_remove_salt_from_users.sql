-- migrations/20231124232251_remove_salt_from_users.sql

ALTER TABLE users DROP COLUMN salt;
