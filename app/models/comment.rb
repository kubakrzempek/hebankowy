module Hebankowy
  module Models
    class Comment < Sequel::Model
      many_to_one :parent, class: self
      one_to_many :replies, key: :parent_id, class: self
      many_to_one :post

      private

      def validate
        super
        validates_presence :content
        validates_presence :ip_address
        validates_presence :author_name
        # validates_presence :author_email
      end
    end
  end
end
