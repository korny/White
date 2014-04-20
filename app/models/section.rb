class Section < ActiveRecord::Base
  include OrderByPosition
  include UrlTitle
  
  has_many :pages, inverse_of: :section
  
  validates :title, length: { maximum: 100 }
  
  validates_url_title_unique
  
  before_save :set_bottom_position
  
  def self.welcome_section
    joins(:pages).where('pages.id IS NOT NULL').first
  end
  
  def welcome_page
    pages.first
  end
  
  def title_visible?
    !title.start_with?('-')
  end
  
  def can_be_deleted?
    pages.empty?
  end
  
  protected
  
  def order_scope
    self.class.all
  end
end
