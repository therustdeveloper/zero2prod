# Builder stage
FROM lukemathwalker/cargo-chef:latest-rust-1.73.0 AS chef

WORKDIR /app
RUN apt update && apt install lld clang -y

FROM chef as planner

COPY . .

RUN cargo chef prepare --recipe-path recipe.json

FROM chef as builder

COPY --from=planner /app/recipe.json recipe.json

RUN cargo chef cook --release --recipe-path recipe.json

COPY . .

ENV SQLX_OFFLINE true

RUN cargo build --release --bin zero2prod

# Runtime state
FROM gcr.io/distroless/cc

WORKDIR /app

COPY --from=builder /app/target/release/zero2prod zero2prod

COPY configuration configuration

ENV APP_ENVIRONMENT production

ENTRYPOINT ["./zero2prod"]