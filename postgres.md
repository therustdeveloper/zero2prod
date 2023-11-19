# PostgreSQL

## Connect to Postgres

```commandline
psql postgres
```

## Create Database

```commandline
postgres=# create database newsletter;
CREATE DATABASE
```

## Create User

```commandline
postgres=# create user newsletter with encrypted password 'metallica';
CREATE ROLE
```

## Assign Permissions to User on the Database

```commandline
postgres=# grant all privileges on database newsletter to newsletter;
GRANT
```

## Grant all on public to newsleter

```commandline
psql newsletter                                                                                                                                                                                       ─╯
psql (15.4 (Homebrew))
Type "help" for help.

newsletter=# grant all on schema public to newsletter;
GRANT
newsletter=#
```

## Create extension

```commandline
postgres=# CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION
```

## Allow create databases

```commandline
postgres=# alter user newsletter createdb;
ALTER ROLE
```

## Environment Variables

```commandline
export DATABASE_URL=postgres://newsletter:metallica@127.0.0.1:5432/newsletter
```

## Create the Subscription Table

```commandline
sqlx migrate add create_subscriptions_table
```

After running this command a new `migrations` directory should appear and also a new SQL file.

## Run the migration

```commandline
sqlx migrate run                                                                                                                                                                                      ─╯
Applied 20231003004241/migrate create subscriptions table (5.215458ms)
```

## List of migrations

```shell
sqlx migrate add add_status_to_subscriptions
```

## Migrate Database to Digital Ocean

Set the password as environment variable

```shell
./scripts/migrate_do_db.sh $DO_DB_PASSWORD
```

## How to connect to Digital Ocean database using psql

This command ask for the password.

```shell
psql -U newsletter -p 25060 -h app-ed2c7f62-1496-4fec-b577-955446e32972-do-user-15018276-0.c.db.ondigitalocean.com newsletter
```