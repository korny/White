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
  
  before_create :set_top_position
  
  after_commit :reprocess_images!, if: -> { previous_changes.key? :images_zoom_factor }
  
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
    images.map do |image|
      Thread.new do
        ActiveRecord::Base.connection_pool.with_connection do
          image.reprocess_picture!
        end
      end
    end.each(&:join)
  end
end
