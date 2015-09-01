class TripPolicy < ApplicationPolicy
  def index?
     # user.present? && record.user == user
     user.present?
  end
end