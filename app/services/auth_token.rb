module Hebankowy
  module Services
    class AuthToken
      class << self
        def issue
          headers = {
            exp: Time.now.to_i + one_day
          }
          JWT.encode({}, secret, algorithm, headers)
        end

        def valid?(token)
          JWT.decode(token, secret, true, algorithm: algorithm)
        rescue
          false
        end

        private

        def secret
          ENVied.SESSION_SECRET
        end

        def algorithm
          "HS512"
        end

        def one_day
          60 * 60 * 24
        end
      end
    end
  end
end
