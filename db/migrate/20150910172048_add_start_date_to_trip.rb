class AddStartDateToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :start_date, :text
    add_column :trips, :end_date, :text
  end
end
