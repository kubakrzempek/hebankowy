require "dotenv"
Dotenv.load

require "bundler"
require "openssl"
require "pry"

$LOAD_PATH << File.expand_path("../", __FILE__)

Bundler.require
ENVied.require

require "app/models"
require "app/representers"
require "app/routes"
require "app/middlewares"
require "app/services"

module Hebankowy
  class App < Sinatra::Application
    configure do
      set :database, lambda {
        ENVied.DATABASE_URL || "postgres://localhost:5432/hebankowy_#{environment}"
      }
    end

    configure do
      set :sessions,
        httponly: true,
        secure: production?,
        expire_after: 3155760,
        secret: ENVied.SESSION_SECRET
      set :views, lambda { File.join(root, "app", "views") }
      set :strict_paths, false
    end

    Dragonfly.app.configure do
      plugin :imagemagick
      secret ENVied.DRAGONFLY_SECRET
      url_format "/uploads/:job/:name"
      datastore :file,
        root_path: "public/uploads",
        server_root: "public"
    end

    use Dragonfly::Middleware

    use Rack::Deflater
    use Rack::Protection
    use Rack::PostBodyContentTypeParser

    use Routes::Api::Posts
    use Routes::Api::Photos
    use Routes::Api::Categories
    use Routes::Api::Tags
    use Routes::Api::Comments
    use Routes::Api::Contact
    use Routes::Api::Sessions

    use Middlewares::Prerender

    get "/*" do
      slim :index
    end
  end
end

include Hebankowy::Models
