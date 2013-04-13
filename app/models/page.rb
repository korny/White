class Page < ActiveRecord::Base
  include OrderByPosition
  include UrlTitle
  
  belongs_to :section, inverse_of: :pages
  
  has_many :images, inverse_of: :page
  
  validates :section_id, presence: true
  validates :title,      length: { maximum: 100 }
  validates :text,       length: { maximum: 10_000 }
  
  validates_url_title_unique scope: [:section_id]
  
  def self.welcome_page
    Section.first.pages.first
  end
  
  protected
  
  def order_scope
    section.try(:pages)
  end
end
