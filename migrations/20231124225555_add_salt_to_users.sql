-- migrations/20231124225555_add_salt_to_users.sql

ALTER TABLE users ADD COLUMN salt TEXT NOT NULL;
