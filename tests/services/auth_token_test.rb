require File.expand_path "../../test_helper", __FILE__

module Hebankowy
  module Services
    class AuthTokenTest < Minitest::Test
      class Issue < AuthTokenTest
        attr_reader :token

        def setup
          @token = AuthToken.issue
        end

        def headers
          JWT.decode(token, ENVied.SESSION_SECRET, true, algorithm: "HS512").last
        end

        def test_ext_header
          assert headers["exp"], "No exp header in the token"
        end
      end

      class Valid < AuthTokenTest
        def test_decoding_valid_token
          token = AuthToken.issue
          assert AuthToken.valid?(token)
        end

        def test_decoding_invalid_token
          refute AuthToken.valid?("lolnope")
        end
      end
    end
  end
end
