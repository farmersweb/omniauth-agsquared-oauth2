# frozen_string_literal: true

require 'omniauth/strategies/oauth2'
require 'uri'

module OmniAuth
  module Strategies
    # Main class for Agsquared OAuth2 strategy.
    class AgsquaredOauth2 < OmniAuth::Strategies::OAuth2
      option :name, 'agsquared'
      option :scope, 'farmersWeb'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options,
        site: 'https://www.agsquared.com',
        authorize_url: 'https://www.agsquared.com/en/authorize',
        token_url: 'https://api.agsquared.com/v1/oauth2/token'

      option :authorize_options, %i[scope redirect_uri]
      option :token_options, %i[scope redirect_uri]

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['id'] }

      info do
        {
          name: raw_info['name'],
          email: raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      

      def raw_info
        ap access_token
        @raw_info ||= access_token.get('https://api.agsquared.com/v1/me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
