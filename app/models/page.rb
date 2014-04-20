class Page < ActiveRecord::Base
  include OrderByPosition
  include UrlTitle
  
  belongs_to :section, inverse_of: :pages
  
  has_many :images, inverse_of: :page
  
  validates :section_id,         presence: true
  validates :title,              length: { maximum: 100 }
  validates :text,               length: { maximum: 10_000 }
  validates :images_zoom_factor, presence: true, numericality: true, inclusion: { in: 1..2000 }
  
  validates_url_title_unique scope: [:section_id]
  
  after_initialize :set_title
  
  after_save :reprocess_images!, if: :images_zoom_factor_changed?
  
  def can_be_deleted?
    images.empty? && text.blank?
  end
  
  protected
  
  def set_title
    self.title ||= Date.today.year.to_s
  end
  
  def order_scope
    section.try(:pages)
  end
  
  def reprocess_images!
    images.each(&:reprocess_picture!)
  end
end
