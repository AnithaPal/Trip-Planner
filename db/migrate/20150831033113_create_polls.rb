class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.text :topic
      t.references :trip, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
