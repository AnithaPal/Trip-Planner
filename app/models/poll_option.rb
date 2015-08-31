class PollOption < ActiveRecord::Base
  belongs_to :poll
  validates :title, presence: true
end
