module Hebankowy
  module Models
    class Tag < Sequel::Model
      many_to_many :posts

      private

      def validate
        super
        validates_presence :name
      end
    end
  end
end
