require 'rails/generators/active_record'
require 'generators/monban/migration/version'

module Monban
  module Generators
    class GoogleOauth2Generator < Rails::Generators::Base
      include Rails::Generators::Migration
      include Monban::Generators::Migration

      source_root File.expand_path("../../templates", __FILE__)

      def add_gems
        gem "omniauth-google-oauth2"
      end

      def add_services
        template 'app/services/external_authentication.rb', 'app/services/external_authentication.rb'
      end

      def add_initializer
        template 'config/initializers/omniauth.rb', 'config/initializers/omniauth.rb'
      end

      def add_routes
        route(%{get "auth/:provider/callback" => "external_credentials#create"})
      end

      def add_controllers
        template 'app/controllers/external_credentials_controller.rb', 'app/controllers/external_credentials_controller.rb'
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

      def add_model
        template 'app/models/external_credential.rb', 'app/models/external_credential.rb'
        migration_template "db/migrate/create_external_credentials.rb", "db/migrate/create_external_credentials.rb", migration_version: migration_version
      end

      def display_readme
        readme 'google_oauth2_readme'
      end
    end
  end
end
