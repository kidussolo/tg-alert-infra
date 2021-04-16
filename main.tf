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

  config_vars = {
    "BOT_TOKEN" = "${var.bot_token}"
    "BASE_URL" = "https://${var.app_name}.herokuapp.com/"
  }
}

resource "heroku_build" "notify" {
  app = heroku_app.notify.name
  buildpacks = [ "https://github.com/heroku/heroku-buildpack-nodejs#latest" ]
  source {
    url = "https://github.com/kidussolo/alert/archive/v1.1.tar.gz"
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