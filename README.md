# Zero to Production in Rust

Developing an API using Rust.

## Development Environment

```commandline
- cargo install cargo-watch
- sudo apt install libssl-dev
- cargo install cargo-tarpaulin
- rustup component add clippy
- cargo install cargo-audit
- cargo install cargo-expand
```
## Installing sqlx-cli

```commandline
cargo install --version="~0.6" sqlx-cli --no-default-features --features rustls,postgres
```

Execute the following command to validate:

```commandline
sqlx --help
```

## PostgreSQL Database

Configure environment variables:

```commandline
DB_USER=${POSTGRES_USER:=postgres}
DB_PASSWORD="${POSTGRES_PASSWORD:=password}"
DB_NAME="${POSTGRES_DB:=newsletter}"
DB_PORT="${POSTGRES_PORT:=5432}"
DB_HOST="${POSTGRES_HOST:=localhost}"
```

Create Database:

```commandline
DATABASE_URL=postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}
export DATABASE_URL
sqlx database create
```

The `sqlx` command doesn't show an output, to validate the database creation run the following command in PostgreSQL:

```commandline
psql --host=localhost --dbname=postgres --username=postgres

postgres=# \l
                                  List of databases
    Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
------------+----------+----------+-------------+-------------+-----------------------
 newsletter | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 postgres   | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
            |          |          |             |             | postgres=CTc/postgres
 template1  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
            |          |          |             |             | postgres=CTc/postgres
(4 rows)            
```

### Create PostgreSQL Username for the Database

```commandline
sudo -u postgres psql
```

Confirm the username:

```commandline
postgres=# select current_user;
 current_user 
--------------
 postgres
(1 row)
```

Move to `newsletter` database:

```commandline
postgres=# \c newsletter
You are now connected to database "newsletter" as user "postgres".
newsletter=# 
```

Create the username:

```commandline
newsletter=# CREATE ROLE newsletter WITH LOGIN PASSWORD 'pa55word';
CREATE ROLE
newsletter=# CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION
newsletter=# exit
```

Connecting as the new user:

```commandline
psql --host=localhost --dbname=newsletter --username=newsletter                       ─╯
Password for user newsletter: 
psql (14.7 (Ubuntu 14.7-0ubuntu0.22.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

newsletter=> 
```

### Add Create Database Permissions to newsletter user

```commandline
postgres=# ALTER USER newsletter CREATEDB;
ALTER ROLE
```

### Configure the workstation

#### Environment Variables

```commandline
DB_USER=${POSTGRES_USER:=newsletter}
DB_PASSWORD="${POSTGRES_PASSWORD:=pa55word}"
DB_NAME="${POSTGRES_DB:=newsletter}"
DB_PORT="${POSTGRES_PORT:=5432}"
DB_HOST="${POSTGRES_HOST:=localhost}"
DATABASE_URL=postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}
export DATABASE_URL
```

## Adding a migration with sqlx

```commandline
sqlx migrate add create_subscriptions_table 
```

## Run the migration

```commandline
sqlx migrate run
Applied 20230408120058/migrate create subscriptions table (11.252282ms)
```
