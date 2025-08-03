module Hebankowy
  module Models
    class Seo < Sequel::Model
      many_to_one :post
    end
  end
end
