require File.expand_path "../../../test_helper", __FILE__

module Api
  class CategoriesTest < Minitest::Test
    def teardown
      Category.all.each(&:destroy)
    end

    def base
      "/api/categories"
    end

    def test_index
      category = Category.create name: "name"
      get "#{base}/"
      assert_equal 200, last_response.status
      assert_instance_of Array, json_body
      assert_equal category.id, json_body.first["id"]
    end

    def test_create_with_valid_params
      initCategoriesCount = Category.count
      params = { name: "test" }
      post "#{base}/", params
      assert_equal 201, last_response.status
      assert_equal initCategoriesCount + 1, Category.count
    end

    def test_create_with_invalid_params
      initCategoriesCount = Category.count
      post "#{base}/", {}
      assert_equal 422, last_response.status
      assert_equal initCategoriesCount, Category.count
    end

    def test_get_existing_category
      category = Category.create name: "test"
      get "#{base}/#{category.name}"
      assert_equal 200, last_response.status
      assert_equal category.id, json_body["id"]
    end

    def get_non_existing_category
      get "#{base}/404"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end

    def test_update_existing_category
      category = Category.create name: "test"
      put "#{base}/#{category.id}", name: "new title"
      category.reload
      assert_equal 200, last_response.status
      assert_equal "new title", category.name
    end

    def test_update_not_existing_category
      put "#{base}/404", name: "new title"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end

    def test_delete_existing_category
      category = Category.create name: "test"
      pre_count = Category.count
      delete "#{base}/#{category.id}"
      assert_equal 200, last_response.status
      assert_equal Category.count, pre_count - 1
    end

    def test_delete_not_existing_category
      delete "#{base}/404"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end
  end
end
