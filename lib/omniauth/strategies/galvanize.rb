require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Galvanize < OmniAuth::Strategies::OAuth2

      option :name, 'galvanize'
      option :client_options, {
        site: 'https://members.galvanize.com',
        authorize_url: '/accounts/authorize',
        token_url: '/accounts/token'
      }

      OmniAuth.config.before_request_phase = lambda do |env|
        if env['omniauth.strategy'].options[:sign_up]
          env['omniauth.strategy'].options[:client_options][:authorize_url] = 'accounts/signup'
        end
      end

      uid do
        raw_result['id']
      end

      info do
        {
          galvanize_id: raw_result['id'],
          onboard_uuid: raw_result['onboard_uuid'],
          email: raw_result['email'],
          name: raw_result['name'],
          first_name: raw_result['first_name'],
          last_name: raw_result['last_name'],
          about: raw_result['about'],
          photo: raw_result['photo'],
          home_location: raw_result['home_location'],
          roles: raw_result['roles'],
          cohort: raw_result['cohorts'], # TODO: deprecate this (without it, raw_result is a direct match)
          cohorts: raw_result['cohorts'],
          companies: raw_result['companies'],
        }
      end

      extra do
        {'raw_info' => raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get('/galvanize-api/v1/me?include_onboard=true').parsed
      end

      def raw_result
        raw_info['results'][0]
      end
    end
  end
end
