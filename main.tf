terraform {
    required_providers {
        heroku = {
            source = "heroku/heroku"
            version = "~>4.0"
        }
    }
}

resource "heroku_app" "notify" {
  name= var.app_name
  region = "us"
}