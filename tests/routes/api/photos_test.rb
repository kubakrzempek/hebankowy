require File.expand_path "../../../test_helper", __FILE__

module Api
  class PhotosTest < Minitest::Test
    def teardown
      Photo.all.each(&:destroy)
    end

    def base
      "/api/photos"
    end

    def test_index
      photo = Photo.create title: "new file", image: "plain text"
      get "#{base}/"
      assert_equal 200, last_response.status
      assert_instance_of Array, json_body
      assert_equal photo.id, json_body.first["id"]
    end

    def test_create_with_valid_params
      skip("It's embarassing the test is skipped")
      initPhotoCount = Photo.count
      params = { title: "title", image: "image" }
      post "#{base}/", params
      assert_equal 201, last_response.status
      assert_equal initPhotoCount + 1, Photo.count
    end

    def test_create_with_invalid_params
      skip("It's embarassing the test is skipped")
      initPhotoCount = Photo.count
      post "#{base}", {}
      assert_equal 422, last_response.status
      assert_equal initPhotoCount, Photo.count
    end

    def test_get_existing_photo
      photo = Photo.create title: "title", image: "plain text"
      get "#{base}/#{photo.id}"
      assert_equal 200, last_response.status
      assert_equal photo.id, json_body["id"]
    end

    def test_get_not_existing_photo
      get "#{base}/404"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end

    def test_update_existing_photo
      photo = Photo.create title: "title", image: "plain text"
      put "#{base}/#{photo.id}", title: "new title"
      photo.reload
      assert_equal 200, last_response.status
      assert_equal "new title", photo.title
    end

    def test_update_not_existing_photo
      put "#{base}/404", title: "new title"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end

    def test_delete_existing_photo
      photo = Photo.create title: "title", image: "plain text"
      pre_count = Photo.count
      delete "#{base}/#{photo.id}"
      assert_equal 200, last_response.status
      assert_equal Photo.count, pre_count - 1
    end

    def test_delete_not_existing_photo
      delete "#{base}/404"
      assert_equal 404, last_response.status
      assert_equal "not found", json_body["message"]
    end
  end
end
