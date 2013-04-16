class User < ActiveRecord::Base
  has_secure_password
  
  validates :password, presence: true, on: :create
  validates :email,    presence: true, uniqueness: true
  
  def self.authenticate_admin password
    find_by(email: 'admin').try(:authenticate, password)
  end
end
