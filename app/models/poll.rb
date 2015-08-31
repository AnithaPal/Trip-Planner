class Poll < ActiveRecord::Base
  belongs_to :trip
  has_many :poll_options

  validates :topic, presence: true
end
