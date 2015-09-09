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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.eager_load(:trippers).where("trips.user_id = ? OR trippers.user_id = ?",  user.id, user.id)
    end
  end
end






