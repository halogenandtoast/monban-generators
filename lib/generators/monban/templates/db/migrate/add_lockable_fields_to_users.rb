class AddLockableFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :failed_logins_count, :integer, default: 0
    add_column :users, :lock_expires_at, :datetime
  end
end
