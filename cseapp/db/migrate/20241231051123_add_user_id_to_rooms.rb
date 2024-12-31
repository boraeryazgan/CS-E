class AddUserIdToRooms < ActiveRecord::Migration[7.0]
  def change
    
    unless column_exists?(:rooms, :user_id)
      add_column :rooms, :user_id, :integer
    end
  end
end
