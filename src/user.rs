use serde::Serialize;

#[derive(Debug, Serialize)]
pub struct User {
    pub name: String,
    pub email: String,
}
