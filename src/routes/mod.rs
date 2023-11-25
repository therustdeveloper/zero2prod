//! src/routes/mod.rs
mod health_check;
mod home;
mod login;
mod newsletters;
mod subscriptions;
mod subscriptions_confirm;
mod system;

pub use health_check::*;
pub use home::*;
pub use login::*;
pub use newsletters::*;
pub use subscriptions::*;
pub use subscriptions_confirm::*;
pub use system::*;
