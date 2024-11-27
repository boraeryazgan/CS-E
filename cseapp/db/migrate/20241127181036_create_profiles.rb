class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :bio
      t.string :location
      t.integer :age
      t.string :gender
      t.text :interests

      t.timestamps
    end
  end
end