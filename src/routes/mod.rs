//! src/routes/mod.rs
mod health_check;
mod subscriptions;
mod subscriptions_confirm;
mod system;
mod newsletters;

pub use health_check::*;
pub use subscriptions::*;
pub use subscriptions_confirm::*;
pub use system::*;
pub use newsletters::*;
