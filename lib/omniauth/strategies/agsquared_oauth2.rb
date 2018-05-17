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

      option :token_options, scope: 'farmersWeb'

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

      def build_access_token
        puts "building access token"
        options.token_params.merge!(:headers => {'Authorization' => basic_auth_header })
        super
      end

      def basic_auth_header
        puts "building basic auth header for #{options[:client_id]}"
        "Basic " + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
      end

      #def authorize_params
      #  super.merge(scope: 'farmersWeb')
      #end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
