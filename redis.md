# Redis Server

## Install Redis

```shell
brew install redis
```

## Start Redis

```shell
brew services start redis
```

## Show Redis Info

```shell
brew services info redis
```

## Stop Redis

```shell
brew services stop redis
```

## Connect to Redis

```shell
redis-cli
```

## List the Digital Ocean Databases

```shell
doctl database list
```

## Get the database connection

```shell
doctl databases connection [ID]
```

You will get something similar to this:

```shell
rediss://default:[PASSWORD]@[HOSTNAME]:25061
```

## References

[Install Redis on macOS](https://redis.io/docs/install/install-redis/install-redis-on-mac-os/)
