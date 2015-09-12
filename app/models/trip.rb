class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :polls

  has_many :trippers, dependent: :destroy
  has_many :users, through: :trippers

  # has_many :invitees, through: :trippers, source: :user

  has_many :invites

  default_scope { order('trips.created_at DESC') }

  validates_presence_of :name

  def is_owner_or_invinted?(person)
    person == user || users.include?(person)
  end

end
