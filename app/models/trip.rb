class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :polls
  
  validates_presence_of :name
end
