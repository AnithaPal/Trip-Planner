class CreateTrippers < ActiveRecord::Migration
  def change
    create_table :trippers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :trip, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :trippers, [:trip_id, :user_id], unique: true
  end
end
