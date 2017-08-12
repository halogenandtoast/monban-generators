class CreatePasswordResets < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :password_resets do |t|
      t.belongs_to :user, index: true
      t.string :token

      t.timestamps
    end
  end
end
