FROM rust:1.78-slim-bookworm AS builder
WORKDIR /app
COPY . .
RUN  cargo build --release

ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

FROM debian:bookworm-slim
WORKDIR /app

RUN adduser book && chown -R book /app
USER book
COPY --from=builder /app/target/release/app ./target/release/app

ENV PORT 8080
EXPOSE $PORT
ENTRYPOINT ["./target/release/app"]