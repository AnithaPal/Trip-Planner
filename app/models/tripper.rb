class Tripper < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  validates_uniqueness_of :user_id, scope: :trip_id, message: " is already a tripper"

  # def self.available_trippers(trip)
  #   all.reject { |u| u == trip.user || trip.users.include?(u) }
  # end
end
