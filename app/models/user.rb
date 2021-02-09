class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 3}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    @user = User.where('lower(email) = ?', email.strip.downcase).first
    # @user = User.find_by(email: email.strip)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
  
end