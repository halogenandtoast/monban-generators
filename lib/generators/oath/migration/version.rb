module Oath
  module Generators
    module Migration
      def rails5_and_up?
        Rails::VERSION::MAJOR >= 5
      end

      def migration_version
        if rails5_and_up?
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
