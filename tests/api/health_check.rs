//! tests/api/health_check.rs

use crate::helpers::{delete_database, spawn_app};

#[tokio::test]
async fn health_check_works() {
    // Arrange
    let app = spawn_app().await;
    let client = reqwest::Client::new();

    // Act
    let response = client
        // Use the returned application address
        .get(&format!("{}/health_check", &app.address))
        .send()
        .await
        .expect("Failed to execute request.");

    // Delete temporal database
    let _db_response = delete_database(app.configuration).await;

    // Assert
    assert!(response.status().is_success());
    assert_eq!(Some(0), response.content_length());
}
