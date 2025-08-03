module Hebankowy
  module Middlewares
    class Prerender
      attr_reader :app, :crawler_user_agents, :extensions_to_ignore

      def initialize(app)
        @app = app
      end

      def call(env)
        if show_prerendered_page?(env)
          prerendered_response = get_prerendered_page_response(env)
          if prerendered_response
            response = build_rack_response(prerendered_response)
            return response.finish
          end
        end
        app.call(env)
      end

      private

      def show_prerendered_page?(env)
        return false if env["REQUEST_METHOD"] != "GET"
        user_agent = env["HTTP_USER_AGENT"]
        request = Rack::Request.new(env)
        # Requesting a resource? Skip...
        return false if extensions_to_ignore.any? { |ext| request.fullpath.include?(ext) }
        # is it a bot? Prerender...
        return true if crawler_user_agents.any? { |agent| user_agent.downcase.include?(agent) }

        return false
      end

      def build_api_url(env)
        url = Rack::Request.new(env).url
        "#{ENVied.PRERENDER_SERVICE_URL}/#{url}"
      end

      def get_prerendered_page_response(env)
        url = URI.parse(build_api_url(env))
        headers = {
          "User-Agent" => env["HTTP_USER_AGENT"],
          "X-Prerender-Token" => ENVied.PRERENDER_TOKEN,
        }
        req = Net::HTTP::Get.new(url.request_uri, headers)
        response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
      rescue
        nil
      end

      def build_rack_response(prerendered_response)
        Rack::Response.new(prerendered_response.body, prerendered_response.code, prerendered_response.header)
      end

      def crawler_user_agents
        [
          "googlebot",
          "yahoo",
          "bingbot",
          "baiduspider",
          "facebookexternalhit",
          "twitterbot",
          "rogerbot",
          "linkedinbot",
          "embedly",
          "bufferbot",
          "quora link preview",
          "showyoubot",
          "outbrain",
          "pinterest",
          "developers.google.com/+/web/snippet",
          "www.google.com/webmasters/tools/richsnippets",
          "slackbot",
          "vkShare",
          "W3C_Validator",
          "redditbot",
          "Applebot",
        ]
      end

      def extensions_to_ignore
        [
          ".js",
          ".css",
          ".png",
          ".jpg",
          ".jpeg",
          ".gif",
          ".ico",
        ]
      end
    end
  end
end
