class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :interests, :string
    add_column :users, :about, :text
  end
end
