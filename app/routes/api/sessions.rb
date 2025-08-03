module Hebankowy
  module Routes
    module Api
      class Sessions < Base
        create_session = lambda do
          if params[:email] == ENVied.ADMINEMAIL && params[:password] == ENVied.PASSWORD
            json({ id_token: Services::AuthToken.issue })
          else
            status 401
            json({ message: "Invalid credentials" })
          end
        end

        namespace "/api/sessions" do
          post "", &create_session
        end
      end
    end
  end
end
