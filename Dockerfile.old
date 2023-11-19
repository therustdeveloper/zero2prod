FROM rust:1.73.0 AS builder
ENV SQLX_OFFILE=true
WORKDIR /app
COPY . .
RUN cargo build --release --target x86_64-unknown-linux-gnu

FROM scratch
WORKDIR /
COPY --from=builder /app/target/x86_64-unknown-linux-gnu/release/zero2prod zero2prod
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT ["./zero2prod"]
EXPOSE 8080