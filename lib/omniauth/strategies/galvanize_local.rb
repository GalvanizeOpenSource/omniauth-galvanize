require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class GalvanizeLocal < OmniAuth::Strategies::OAuth2
      option :name, 'galvanize_local'

      option :client_options, {
                                :site => 'http://localhost:4000',
                                :authorize_url => '/accounts/authorize',
                                :token_url => '/accounts/token'
                            }

      uid{ raw_info['results'][0]['id'] }

      info do
        {
            :email => raw_info['results'][0]['email'],
            :name => raw_info['results'][0]['name'],
            :first_name => raw_info['results'][0]['first_name'],
            :last_name => raw_info['results'][0]['last_name'],
            :galvanize_id => raw_info['results'][0]['id'],
            :about => raw_info['results'][0]['about'],
            :photo => raw_info['results'][0]['photo'],
            :roles => raw_info['results'][0]['roles']
        }
      end

      extra do
        {
            'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v3/me').parsed
      end
    end
  end
end