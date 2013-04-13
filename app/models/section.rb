class Section < ActiveRecord::Base
  include OrderByPosition
  include UrlTitle
  
  has_many :pages, inverse_of: :section
  
  validates :title, length: { maximum: 100 }
  
  validates_url_title_unique
  
  def self.welcome_section
    first
  end
  
  def welcome_page
    pages.first
  end
  
  protected
  
  def order_scope
    self.class.all
  end
end
