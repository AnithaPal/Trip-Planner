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
      # scope.where(user: user)
      scope.eager_load(:trippers).where("trips.user_id = ? OR trippers.user_id = ?",  user.id, user.id)
    end
    # def resolve 
    #   trips = []
    #   all_trips = scope.all
    #   all_trips.each do |trip|
    #     if trip.user == user || trip.users.include?(user)
    #       trips << trip
    #     end
    #   end
    #   trips
    # end
  end
end






