class RemoveBlockedAndAddStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :blocked, :string
    add_column :users, :status, :string, default: 'active', null: false
  end
end
