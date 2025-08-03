Sequel.database_timezone = :utc
Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :validation_helpers

module Hebankowy
  module Models
    autoload :Post, "app/models/post"
    autoload :Photo, "app/models/photo"
    autoload :Category, "app/models/category"
    autoload :Tag, "app/models/tag"
    autoload :Comment, "app/models/comment"
    autoload :Seo, "app/models/seo"
  end
end
