module Hebankowy
  module Routes
    module Api
      class Base < Hebankowy::Routes::Base
        register Sinatra::Namespace

        before do
          content_type "application/json"
        end

        error Sequel::NoMatchingRow do
          not_found
        end

        private

        def not_found
          status 404
          json({ message: "not found" })
        end
      end
    end
  end
end
