module Hebankowy
  module Routes
    autoload :Base, "app/routes/base"
    module Api
      module Admin
        autoload :Base, "app/routes/api/admin/base"
      end
      autoload :Base, "app/routes/api/base"
      autoload :Posts, "app/routes/api/posts"
      autoload :Photos, "app/routes/api/photos"
      autoload :Categories, "app/routes/api/categories"
      autoload :Tags, "app/routes/api/tags"
      autoload :Comments, "app/routes/api/comments"
      autoload :Contact, "app/routes/api/contact"
      autoload :Sessions, "app/routes/api/sessions"
    end
  end
end
