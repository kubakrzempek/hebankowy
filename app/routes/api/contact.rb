module Hebankowy
  module Routes
    module Api
      class Contact < Base
        post_form = lambda do
          mg_client = Mailgun::Client.new ENVied.MAILGUN_API_KEY

          content = "#{params[:name]} <#{params[:email]}> napisał:\n\n\n#{params[:content]}"

          message_params =  { from: "#{params[:name]} <#{ENVied.MAILGUN_FROM}>",
                              to: ENVied.EMAIL_TO,
                              "h:Reply-To": "#{params[:name]} <#{params[:email]}>",
                              subject: "Email ze strony hebankowy.pl",
                              text: content,
                            }
          mg_client.send_message ENVied.MAILGUN_API_URL, message_params
          status 201
        end

        namespace "/api/contact" do
          post "", &post_form
        end
      end
    end
  end
end
