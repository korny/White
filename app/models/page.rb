class Page < ActiveRecord::Base
  include OrderByPosition
  
  belongs_to :section, inverse_of: :pages
  
  has_many :images, inverse_of: :page
  
  validates :section_id, presence: true
  validates :title,      length: { maximum: 100 }
  validates :text,       length: { maximum: 10_000 }
  
  def self.welcome_page
    Section.first.pages.first
  end
  
  protected
  
  def order_scope
    section.pages
  end
end
