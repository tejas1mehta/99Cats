class Session < ActiveRecord::Base
  validates :user_id, :session_token, presence: true

  belongs_to :user

  def self.create_session_token
    SecureRandom::urlsafe_base64(16)
  end


end
