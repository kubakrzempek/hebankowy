module Hebankowy
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, File.expand_path("../../../", __FILE__)
        set :strict_paths, false
      end
    end
  end
end
