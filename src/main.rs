use std::net::TcpListener;
use zero2prod::startup;

#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    let listener = TcpListener::bind("127.0.0.1:8000")
        .expect("Failed to bind the port.");

    startup::run(listener)?.await
}
