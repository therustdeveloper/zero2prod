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
- cargo install cargo-udeps
- 
```
## Installing sqlx-cli

```shell
cargo install --version="~0.6" sqlx-cli --no-default-features --features rustls,postgres
```

### Generate queries to run in offline mode

```shell
cargo sqlx prepare -- --lib                                                                                                                                                                           ─╯
    Checking zero2prod v0.1.0 (/Users/william/workspace/rust/zero2prod)
    Finished dev [unoptimized + debuginfo] target(s) in 1.78s
query data written to `sqlx-data.json` in the current directory; please check this into version control
```

Execute the following command to validate:

```commandline
sqlx --help
```

## PostgreSQL Database

On macOS I installed PostgreSQL Database using the official installation, the PATH is:

```commandline
/Library/PostgreSQL/15
```

Append the `bin` directory to the PATH in `.zprofile` configuration file:

```commandline
export PATH=$PATH:/Library/PostgreSQL/15/bin
```

Configure environment variables:

```commandline
DB_USER=${POSTGRES_USER:=postgres}
DB_PASSWORD="${POSTGRES_PASSWORD:=admin}"
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
mkdir migrations
```

The following command will create a new file on `migrations` directory:

```commandline
sqlx migrate add create_subscriptions_table 
```

## Run the migration

```commandline
sqlx migrate run
Applied 20230408120058/migrate create subscriptions table (11.252282ms)
```

## Application Deployment to Digital Ocean

### Create the application

```shell
doctl apps create --spec spec.yaml
```

### List the applications

```shell
doctl apps list
```

### Delete an application

```shell
doctl apps delete APPLICATION_ID
```

## Host to list of targets with Rust

```shell
docker run -t -i rust:1.73.0 rustc --print target-list
```

## Apply the changes to DigitalOcean

Grab your app identifier via: 

```shell
doctl apps list --format ID
```

Update the application:

```shell
doctl apps update $APP_ID --spec spec.yaml
```

## Running a test and validating errors logs

Installing `bunyan`:

```rust
cargo install bunyan
```

```shell
cargo t subscribe_fails_if_there_is_a_fatal_database_error | bunyan
```