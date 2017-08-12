module Monban
  module Generators
    module Migration
      def migration_version
        if Rails.version.start_with? '5'
          "[#{ActiveRecord::Migration.current_version}]"
        end
      end
    end
  end
end
