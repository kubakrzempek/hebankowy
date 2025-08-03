module Hebankowy
  module Representers
    autoload :Post, "app/representers/post"
    autoload :Photo, "app/representers/photo"
    autoload :Category, "app/representers/category"
    autoload :Tag, "app/representers/tag"
    autoload :Comment, "app/representers/comment"
  end
end
