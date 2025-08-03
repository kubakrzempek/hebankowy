require File.expand_path "../../test_helper", __FILE__

module PostTestShares
  attr_reader :post

  def setup
    @post = Post.new title: "title", content: "content"
  end
end

class PostTest < Minitest::Test
  include PostTestShares

  def test_valid_post
    assert post.valid?, post.errors
  end

  def test_invalid_post
    post = Post.new
    refute post.valid?
    assert_includes post.errors[:title], "is not present"
    assert_includes post.errors[:content], "is not present"
  end

  def test_cover_photo
    cover = Photo.create title: "cover", image: "image"
    featured = Photo.create title: "featured", image: "image"
    post = Post.new featured_photo: featured
    assert_equal featured, post.cover
    post.cover_photo = cover
    assert_equal cover, post.cover
  end

  def test_associations
    post = Post.new
    assert post.respond_to?(:cover_photo), "Cover not associated"
    assert post.respond_to?(:featured_photo), "Featured photo not associated"
    assert post.respond_to?(:categories), "Categories not associated"
    assert post.respond_to?(:tags), "Tags not associated"
    assert post.respond_to?(:seo), "Seo not associated"
  end

  def test_like!
    post.like!
    assert_equal post.likes, 1
  end

  class Similar < Minitest::Test
    include PostTestShares
    attr_reader :ids

    def setup
      @category = Category.create(name: "category")
      @post = Post.create(title: "title", content: "content")
      @category_post = Post.create(title: "title", content: "content")
      @category.add_post(@post)
      @category.add_post(@category_post)
      @non_category_post = Post.create(title: "title", content: "content")
      @ids = @post.similar.map(&:id)
    end

    def test_returns_posts_from_the_same_category
      assert ids.include?(@category_post[:id]), "Post from category not returned!"
    end

    def test_doesnt_return_post_from_other_categories
      refute ids.include?(@non_category_post[:id]), "Post from other category returned!"
    end

    def test_doesnt_return_self
      refute ids.include?(post[:id]), "returned self"
    end

    class WhenThereAreMoreThan3Items < Minitest::Test
      include PostTestShares

      def setup
        @category = Category.create(name: "category")
        @post = Post.create(title: "title", content: "content")
        @category_post = Post.create(title: "title", content: "content")
        @category.add_post(@post)
        @category.add_post(@category_post)
        @non_category_post = Post.create(title: "title", content: "content")
        @ids = @post.similar.map(&:id)
        3.times do
          post = Post.create(title: "title", content: "content")
          post.add_category(@category)
        end
      end

      def test_returns_max_3_items
        assert_equal 3, post.similar.length, "Returned more than 3 items"
      end
    end
  end
end
