require File.expand_path "../../../test_helper", __FILE__

module Api
  class CommentsTest < Minitest::Test
    def teardown
      Comment.all.each(&:destroy)
    end

    def valid_params
      {
        author_name: "Test user",
        author_email: "user@example.com",
        content: "Awesome post!",
      }
    end

    def base
      "/api/comments"
    end

    def test_create_with_valid_params
      initCommentCount = Comment.count
       post "#{base}/", valid_params
       assert_equal 201, last_response.status
       assert_equal Comment.count, initCommentCount + 1
     end

    def test_create_with_invalid_params
      initCommentCount = Comment.count
      post "#{base}/", {}
      assert_equal 422, last_response.status
      assert_equal Comment.count, initCommentCount
    end

    def test_delete_existing_comment
      comment = Comment.create valid_params.merge(ip_address: "127.0.0.1")
      pre_count = Comment.count
      delete "#{base}/#{comment.id}"
      assert_equal 200, last_response.status
      assert_equal Category.count, pre_count - 1
    end

    def test_delete_non_existing_comment
      delete "#{base}/404"
      assert_equal 404, last_response.status
      assert_equal json_body["message"], "not found"
    end
  end
end
