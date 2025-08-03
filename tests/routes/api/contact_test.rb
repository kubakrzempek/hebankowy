require File.expand_path "../../../test_helper", __FILE__

module Api
  class ContactTest < Minitest::Test
    def base
      "/api/contact"
    end

    def params
      {
        name: "my name",
        email: "email@email.com",
        content: "this is the contect",
      }
    end

    def test_post
      # post "#{base}/", params
      # assert_equal 201, last_response.status
    end
  end
end
