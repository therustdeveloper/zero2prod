//! src/routes/subscriptions.rs
use actix_web::{web, HttpResponse};

#[derive(serde::Deserialize)]
pub struct FormData {
    email: String,
    name: String
}

pub async fn subscribe(form: web::Form<FormData>) -> HttpResponse {
    println!("Form email: {}", form.email);
    println!("Form name: {}", form.name);
    HttpResponse::Ok().finish()
}
