#FROM messense/rust-musl-cross:x86_64-musl as builder
FROM rust:1.73.0 AS builder
ENV SQLX_OFFILE=true
WORKDIR /app
COPY . .
RUN cargo build --release
#--target x86_64-unknown-linux-musl

FROM scratch
#COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/zero2prod zero2prod
COPY --from=builder /app/target/release/zero2prod zero2prod
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT ["/zero2prod"]
EXPOSE 8080