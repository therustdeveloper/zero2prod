# Generate recipe file for dependencies
FROM lukemathwalker/cargo-chef:latest-rust-1.73.0 as chef
#FROM rust as planner
WORKDIR /app
RUN apt update && apt install lld clang -y

# Build Dependencies
FROM chef as planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# Builder Image
FROM chef as builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
ENV SQLX_OFFLINE true
RUN cargo sqlx prepare && cargo build --release --bin zero2prod

# Running Image
FROM debian:stable-slim
WORKDIR /app
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/zero2prod /app/zero2prod
COPY configuration /app/configuration
ENV APP_ENVIRONMENT production
CMD ["./zero2prod"]
