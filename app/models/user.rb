class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.where('lower(email) = ?', email.downcase.strip).first
    user && user.authenticate(password) ? user : nil
  end
end
