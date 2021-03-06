require 'rails/generators/migration'
require 'rails/generators/active_record'

module ActsAsChattable
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    namespace "acts_as_chattable:migration"

    source_root File.join(File.dirname(__FILE__), 'templates')

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

    def create_migration_file
      migration_template 'migration.rb', 'db/migrate/create_messages_table.rb' rescue nil
      migration_template 'migration_permanent.rb', 'db/migrate/add_recipient_permanent_delete_and_sender_permanent_delete_to_messages.rb' rescue nil
    end
  end
end
