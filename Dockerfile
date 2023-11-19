# Generate recipe file for dependencies
FROM rust as planner
ENV SQLX_OFFILE=true
WORKDIR /app
RUN cargo install cargo-chef
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# Build Dependencies
FROM rust as cacher
ENV SQLX_OFFILE=true
WORKDIR /app
RUN cargo install cargo-chef
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json

# Builder Image
FROM rust as builder
ENV USER=web
ENV UID=1001
ENV SQLX_OFFILE=true

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"

COPY . /app
WORKDIR /app
COPY --from=cacher /app/target target
COPY --from=cacher /usr/local/cargo /usr/local/cargo
RUN cargo build --release

# Running Image
FROM gcr.io/distroless/cc-debian11
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /app/target/release/zero2prod /app/zero2prod
COPY configuration /app/configuration

WORKDIR /app

USER web:web

CMD ["./zero2prod"]