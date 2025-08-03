require File.expand_path "../../../test_helper", __FILE__

module Api
  class SessionTest < Minitest::Test

    def base
      "/api/admin/sessions"
    end

    def valid_params
      { email: "admin@example.com", password: "password" }
    end

    def test_create_without_valid_credentials
      post "#{base}"
      assert_equal 401, last_response.status
      assert_equal "Invalid credentials", json_body["message"]
    end

    def test_create_with_valid_credentials
      post "#{base}", valid_params
      assert_equal 200, last_response.status
      assert json_body["id_token"]
    end
  end
end
