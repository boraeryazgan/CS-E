class AddFriendsAndBlockedUsersToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :friends, :text
    add_column :users, :blocked_users, :text
  end
end
