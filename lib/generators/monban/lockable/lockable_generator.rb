require 'rails/generators/active_record'

module Monban
  module Generators
    class LockableGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../../templates", __FILE__)

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

      def add_model
        migration_template "db/migrate/add_lockable_fields_to_users.rb", "db/migrate/add_lockable_fields_to_users.rb"
      end

      def copy_model_concerns
        copy_file "app/models/concerns/monban_lockable.rb", "app/models/concerns/monban_lockable.rb"
      end

      def copy_lockable_initializer_file
        copy_file "config/initializers/monban_lockable.rb", "config/initializers/monban_lockable.rb"
      end

      def add_translations
        template "config/locales/monban.en.yml"
      end

      def display_readme
        readme 'lockable_readme'
      end
    end
  end
end
