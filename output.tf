output "notify_app_url" {
  value = "https://${heroku_app.notify.name}.herokuapp.com"
}