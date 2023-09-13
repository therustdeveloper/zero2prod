use actix_web::HttpResponse;

pub async fn system() -> HttpResponse {
    HttpResponse::Ok().finish()
}
