class User < ActiveRecord::Base
  has_secure_password
  
  validates :password, presence: true, on: :create
  validates :email,    presence: true, uniqueness: true
  
  def self.authenticate_admin password
    admin.try(:authenticate, password)
  end
  
  def self.admin
    find_by email: 'admin'
  end
end
