class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :trip, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :category
      t.integer :amount_spent

      t.timestamps null: false
    end
  end
end
