class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :room_name
      t.decimal :price_per_night, precision: 10, scale: 2
      t.text :description
      t.string :address
      t.string :room_image
      t.timestamps
    end
  end
end
