//! src/routes/mod.rs
mod admin;
mod health_check;
mod home;
mod login;
mod subscriptions;
mod subscriptions_confirm;
mod system;

pub use admin::*;
pub use health_check::*;
pub use home::*;
pub use login::*;
pub use subscriptions::*;
pub use subscriptions_confirm::*;
pub use system::*;
