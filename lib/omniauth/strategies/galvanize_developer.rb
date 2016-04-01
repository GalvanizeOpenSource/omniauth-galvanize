require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class GalvanizeDeveloper
      include OmniAuth::Strategy

      option :name, 'galvanize_developer'
      option :fields, [:first_name, :last_name, :email, :role, :cohorts, :galvanize_id, :home_location, :onboard_uuid, :photo, :home_location]
      option :role_fields, [:role]
      option :cohort_fields, [:cohort]
      option :uid_field, :galvanize_id

      def request_phase
        form = OmniAuth::Form.new(:title => 'User Info', :url => callback_path)
        options.fields.each do |field|
          form.text_field field.to_s.capitalize.gsub('_', ' '), field.to_s
        end
        form.button 'Sign In'
        form.to_response
      end

      uid do
        request.params[options.uid_field.to_s]
      end

      info do
        roles_array = []
        cohorts_array = []
        options.fields.inject({}) do |hash, field|
          if options.role_fields.include?(field)
             roles_array << {name: request.params[field.to_s], description: "The description for #{field.to_s}"} unless request.params[field.to_s].blank?
          elsif options.cohort_fields.include?(field)
             cohorts_array << {name: request.params[field.to_s]} unless request.params[field.to_s].blank?
          else
            hash[field] = request.params[field.to_s]
          end

          hash[:roles] = roles_array
          hash[:cohorts] = cohorts_array
          hash
        end
      end
    end
  end
end
