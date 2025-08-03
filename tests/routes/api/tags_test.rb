require File.expand_path "../../../test_helper", __FILE__

module Api
  class TagsTest < Minitest::Test
    def teardown
      Tag.all.each(&:destroy)
    end

    def base
      "/api/tags"
    end

    def test_index
      tag = Tag.create name: "name"
      get "#{base}/"
      assert_equal 200, last_response.status
      assert_instance_of Array, json_body
      assert_equal tag.id, json_body.first["id"]
    end

    def test_create_with_valid_params
      initCategoriesCount = Tag.count
      params = { name: "test" }
      post "#{base}/", params
      assert_equal 201, last_response.status
      assert_equal initCategoriesCount + 1, Tag.count
    end

    def test_create_with_invalid_params
      initCategoriesCount = Tag.count
      post "#{base}/", {}
      assert_equal 422, last_response.status
      assert_equal initCategoriesCount, Tag.count
    end

    def test_get_existing_tag
      tag = Tag.create name: "test"
      get "#{base}/#{tag.id}"
      assert_equal 200, last_response.status
      assert_equal tag.id, json_body["id"]
    end

    def get_non_existing_tag
      get "#{base}/404"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end

    def test_update_existing_tag
      tag = Tag.create name: "test"
      put "#{base}/#{tag.id}", name: "new title"
      tag.reload
      assert_equal 200, last_response.status
      assert_equal "new title", tag.name
    end

    def test_update_not_existing_tag
      put "#{base}/404", name: "new title"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end

    def test_delete_existing_tag
      tag = Tag.create name: "test"
      pre_count = Tag.count
      delete "#{base}/#{tag.id}"
      assert_equal 200, last_response.status
      assert_equal Tag.count, pre_count - 1
    end

    def test_delete_not_existing_tag
      delete "#{base}/404"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end
  end
end
