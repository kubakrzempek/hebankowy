module Hebankowy
  module Models
    class Post < Sequel::Model
      subset(:published) { published_at < Time.now }

      many_to_many :categories
      many_to_many :tags
      many_to_one :cover_photo, class: Photo
      many_to_one :featured_photo, class: Photo
      one_to_many :comments, eager: :replies
      one_to_one :seo

      def cover
        cover_photo ? cover_photo : featured_photo
      end

      def like!
        self.likes += 1
        save
      end

      def publish!
        self.published_at = DateTime.now
        save
      end

      def comments_count
        comments
          .map { |c| c.replies.count }
          .inject(comments.count) { |sum, c| sum + c }
      end

      def similar
        categories.first.posts_dataset.published.exclude(id: id).all.sample(3)
      rescue
        []
      end

      def new_version?
        created_at > Time.parse("2019-05-12")
      end

      private

      def after_create
        self.seo = Seo.create
        super
      end

      def validate
        super
        validates_presence [:title, :content]
      end
    end
  end
end
