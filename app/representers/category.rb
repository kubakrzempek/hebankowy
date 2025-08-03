module Hebankowy
  module Representers
    Category = Struct.new(:category) do
      def basic
        {
          id: category.id,
          name: category.name,
          created_at: category.created_at,
          updated_at: category.updated_at,
          icon: category.icon ? Representers::Photo.new(category.icon).basic : {},
          photo: category.photo ? Representers::Photo.new(category.photo).basic : {},
        }
      end

      def with_posts
        basic.merge(
          posts: published_posts.map { |post| Representers::Post.new(post).minimal }
        )
      end

      private

      def published_posts
        category
          .posts_dataset
          .published
          .reverse_order(:published_at)
      end
    end
  end
end
