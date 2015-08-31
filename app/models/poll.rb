class Poll < ActiveRecord::Base
  belongs_to :trip
  has_many :poll_options
  accepts_nested_attributes_for :poll_options, :reject_if => :all_blank, :allow_destroy => true

  validates :topic, presence: true
end
