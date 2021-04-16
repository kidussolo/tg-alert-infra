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

resource "heroku_build" "notify" {
  app = heroku_app.notify.name
  buildpacks = [ "https://github.com/heroku/heroku-buildpack-nodejs#latest" ]
  source {
    url = "https://github.com/kidussolo/alert/archive/v1.0.tar.gz"
    version = "1.0"
  }
}

resource "heroku_formation" "name" {
  app = heroku_app.notify.name
  type = "web"
  quantity = 1
  size = "free"
  depends_on = [heroku_build.notify]
}