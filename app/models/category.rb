module Hebankowy
  module Models
    class Category < Sequel::Model
      many_to_one :photo
      many_to_one :icon, class: Photo, key: :icon_id
      many_to_many :posts

      private

      def validate
        super
        validates_presence :name
      end
    end
  end
end
