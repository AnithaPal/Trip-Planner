class TripPolicy < ApplicationPolicy
  def index?
     user.present? 
  end

  def show?
    record.user == user || record.users.include?(user)
  end

  def edit?
    show?
  end

  def update?
    show?
  end
end