require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Galvanize < OmniAuth::Strategies::OAuth2
      option :name, 'galvanize'

      option :client_options, {
                                :site => 'https://members.galvanize.com',
                                :authorize_url => '/accounts/authorize',
                                :token_url => '/accounts/token'
                            }

      SETUP_PROC = lambda do |env|
        if env['omniauth.strategy'].options[:sign_up]
          env['omniauth.strategy'].options[:client_options][:authorize_url] = 'accounts/signup'
        end
      end

      OmniAuth.config.before_request_phase = SETUP_PROC

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
            :roles => raw_info['results'][0]['roles'],
            :home_location => raw_info['results'][0]['home_location'],
            :cohort => raw_info['results'][0]['cohorts']
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
