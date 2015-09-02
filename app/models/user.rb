class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  # has_many :trips
  has_many :trips, through: :trippers
  has_many :trippers, dependent: :destroy
  
  has_many :votes, dependent: :destroy
  has_many :poll_options, through: :votes

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
    end
  end

  def owner?
    role == 'owner'
  end

  def guest?
    role == 'guest'
  end

  # def voted_for?(poll)
  #   votes.any? {|v| v.poll_option.poll == poll}
  # end

  def voted_for?(poll)
    # user > votes < po < poll
    poll_options.includes(:poll).where(poll: poll).present?
  end
  
end
