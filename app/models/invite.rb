class Invite < ActiveRecord::Base
  belongs_to :trip
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  before_create :generate_token
  before_save :check_user_existence

  # validates_uniqueness_of :recipient_id, :class_name => 'User', scope: :trip_id, message: " Invitation has already sent for this trip"

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.trip_id, Time.now, rand].join)
  end

  def check_user_existence
    recipient = User.find_by(email: email)
    if recipient
      self.recipient_id = recipient.id
    end
  end

  def accepted
    self.status = "accept"
    Tripper.create(user: recipient, trip: trip)
    save
  end

  def declined
    self.status = "decline"
    save
  end

end
