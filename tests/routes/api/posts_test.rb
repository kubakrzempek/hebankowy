require File.expand_path "../../../test_helper", __FILE__

module Api
  class PostsTest < Minitest::Test
    def teardown
      Post.all.each(&:delete)
    end

    def base
      "/api/posts"
    end

    def test_index
      post = Post.create title: "title", content: "body"
      get "#{base}/"
      assert_equal last_response.status, 200
      assert_instance_of Array, json_body
      assert_equal json_body.first["id"], post.id
    end

    def test_create_with_valid_params
      initPostCount = Post.count
      params = Post.new(title: "title", content: "body").values
      post "#{base}/", params
      currentPostCount = Post.count
      assert_equal currentPostCount, initPostCount + 1
      assert_equal last_response.status, 201
    end

    def test_create_with_invalid_params
      initPostCount = Post.count
      params = Post.new.values
      post "#{base}/", params
      currentPostCount = Post.count
      assert_equal currentPostCount, initPostCount
      assert_equal last_response.status, 422
    end

    def test_get_existing_post
      post = Post.create title: "title", content: "body"
      get "#{base}/#{post.id}"
      assert_equal json_body["id"], post.id
    end

    def test_get_not_existing_post
      get "#{base}/404"
      assert_equal last_response.status, 404
      assert_equal json_body["message"], "not found"
    end

    def test_update_existing_post
      post = Post.create title: "title", content: "body"
      put "#{base}/#{post.id}", post: { title: "new title" }
      post.reload
      assert_equal post.title, "new title"
    end

    def test_update_not_existing_post
      put "#{base}/404", title: "new title"
      assert_equal last_response.status, 404
      assert_equal json_body["message"], "not found"
    end

    def test_delete_existing_post
      post = Post.create title: "title", content: "body"
      pre_count = Post.count
      delete "#{base}/#{post.id}"
      assert_equal pre_count - 1, Post.count
    end

    def test_delete_not_existing_post
      delete "#{base}/404"
      assert_equal last_response.status, 404
      assert_equal json_body["message"], "not found"
    end

    def test_like_post
      post = Post.create title: "title", content: "body"
      post "#{base}/#{post.id}/like"
      post.reload
      assert_equal post.likes, 1
    end
  end
end
