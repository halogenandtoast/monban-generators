require 'rails/generators/active_record'
require 'generators/monban/migration/version'

module Monban
  module Generators
    class ScaffoldGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      include Monban::Generators::Migration

      source_root File.expand_path("../../templates", __FILE__)

      def add_routes
        route("resources :users, only: [:new, :create]")
        route("resource :session, only: [:new, :create, :destroy]")
      end

      def add_views
        copy_file 'app/views/users/new.html.erb'
        copy_file 'app/views/sessions/new.html.erb'
      end

      def add_controllers
        template 'app/controllers/sessions_controller.rb', 'app/controllers/sessions_controller.rb'
        template 'app/controllers/users_controller.rb', 'app/controllers/users_controller.rb'
      end

      def add_helper_module_to_application_controller
        inject_into_class "app/controllers/application_controller.rb", ApplicationController, "  include Monban::ControllerHelpers\n"
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

      def add_model
        template 'app/models/user.rb', 'app/models/user.rb'
        migration_template "db/migrate/create_users.rb", "db/migrate/create_users.rb", migration_version: migration_version
      end

      def add_translations
        template "config/locales/monban.en.yml"
      end

      def display_readme
        readme 'scaffold_readme'
      end
    end
  end
end
