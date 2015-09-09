class Tripper < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

  validates_uniqueness_of :user_id, scope: :trip_id, message: " is already a tripper"

end
