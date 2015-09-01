class Poll < ActiveRecord::Base
  belongs_to :trip
  has_many :poll_options
  accepts_nested_attributes_for :poll_options, :reject_if => :all_blank, :allow_destroy => true

  validates :topic, presence: true

  def normalized_votes_for(option)
    votes_summary == 0 ? 0 : (option.votes.count.to_f / votes_summary) * 100
  end

  def votes_summary
    poll_options.inject(0) {|summary, option| summary + option.votes.count}
  end
end
