FROM rust:alpine as builder
RUN apk update && apk add --no-cache musl-dev
WORKDIR /home/rust
COPY . .
RUN cargo build --release --target=x86_64-unknown-linux-musl

FROM scratch
COPY --from=builder /home/rust/target/x86_64-unknown-linux-musl/release/axum-sample /axum-sample
EXPOSE 3000
ENTRYPOINT [ "/axum-sample" ]