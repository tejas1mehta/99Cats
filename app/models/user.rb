class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  before_validation :ensure_session_token
  attr_reader :password

  has_many :cats

  def self.create_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.create_session_token
    self.save!
    return self.session_token
  end

  def password=(password_pt)
    if password_pt.present?
      @password = password_pt
      self.password_digest = BCrypt::Password.create(password_pt)
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    if user
      user.is_password?(password) ? user : nil
    else
      return nil
    end

  end


  private
  def ensure_session_token

    self.session_token ||= self.class.create_session_token

  end

end
