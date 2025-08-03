module Hebankowy
  module Representers
    Post = Struct.new(:post) do
      def basic
        {
          id: post.id,
          title: post.title,
          content: post.content,
          slug: post.slug,
          distance: post.distance,
          teaser: post.teaser,
          hints: post.hints,
          route: post.route,
          location: post.location,
          categories: categories,
          tags: tags,
          featured_photo: featured_photo,
          banner_photo_url: post.banner_photo_url,
          cover_photo_url: post.cover_photo_url,
          featured_photo_url: post.featured_photo_url,
          mobile_cover_photo_url: post.mobile_cover_photo_url,
          mobile_featured_photo_url: post.mobile_featured_photo_url,
          likes: post.likes,
          cover: cover_photo,
          comments: comments,
          comments_count: post.comments_count,
          created_at: post.created_at,
          updated_at: post.updated_at,
          published_at: format_date(post.published_at),
          seo: post_seo,
          similar: similars,
          new_version: post.new_version?,
        }
      end

      def minimal
        {
          id: post.id,
          title: post.title,
          slug: post.slug,
          distance: post.distance,
          teaser: (post.teaser || "").split("|").map(&:strip),
          categories: categories,
          tags: tags,
          likes: post.likes,
          banner_photo_url: post.banner_photo_url,
          mobile_cover_photo_url: post.mobile_cover_photo_url,
          cover_photo_url: post.cover_photo_url,
          cover: cover_photo(1100),
          comments_count: post.comments_count,
          created_at: post.created_at,
          updated_at: post.updated_at,
          published_at: format_date(post.published_at),
        }
      end

      private

      def comments
        post
          .comments_dataset
          .reverse_order(:created_at)
          .map { |comment| Representers::Comment.new(comment).basic }
      end

      def tags
        post.tags.map { |tag| Representers::Tag.new(tag).basic }
      end

      def similars
        post.similar.map { |post| Representers::Post.new(post).minimal }
      end

      def categories
        post.categories.map { |category| Representers::Category.new(category).basic }
      end

      def featured_photo
        post.featured_photo ? Representers::Photo.new(post.featured_photo).basic : {}
      end

      def cover_photo(width = false)
        post.cover ? Representers::Photo.new(post.cover, width).basic : {}
      end

      def post_seo
        seo = post.seo
        {
          title: seo.title,
          description: seo.description,
          image: seo.image,
        }
      end

      def format_date(date)
        return unless date
        date.strftime("%F")
      end
    end
  end
end
