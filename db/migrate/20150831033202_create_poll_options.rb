class CreatePollOptions < ActiveRecord::Migration
  def change
    create_table :poll_options do |t|
      t.string :title
      t.references :poll, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
