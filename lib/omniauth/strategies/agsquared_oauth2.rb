# frozen_string_literal: true

require "omniauth/strategies/oauth2"
require "uri"

module OmniAuth
  module Strategies
    # Main class for Agsquared OAuth2 strategy.
    class AgsquaredOauth2 < OmniAuth::Strategies::OAuth2
      option :name, "agsquared"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options,
        site: "https://www.agsquared.com",
        authorize_url: "/en/authorize",
        token_url: "/en/authorize/token"

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info["id"] }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"]
        }
      end

      extra do
        {
          "raw_info" => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/me").parsed
      end
    end
  end
end
