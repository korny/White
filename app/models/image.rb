class Image < ActiveRecord::Base
  include OrderByPosition
  include UrlTitle
  
  belongs_to :page, inverse_of: :images
  
  has_attached_file :picture, styles: -> (attachment) {
    size = attachment.instance.size_for_thumbnail
    {
      thumb: "#{size}x#{size}>",
    }
  }, :default_url => "/images/:style/missing.png"
  
  scope :has_picture, -> { where 'picture_file_name IS NOT NULL' }
  
  validates :page_id,        presence: true
  validates :title,          length: { maximum: 200 }
  validates :caption,        length: { maximum: 250 }
  validates :height, :width, numericality: { allow_nil: true }
  validates :picture,        :attachment_presence => true
  
  validates_url_title_unique
  
  before_validation :set_url_title_from_filename, if: :picture?
  
  def size_for_thumbnail
    (long_side * (page.images_zoom_factor / 100.0)).round
  end
  
  def long_side
    width && height ? [height, width].max : 100
  end
  
  protected
  
  def set_url_title_from_filename
    File.basename(picture.original_filename, '.*').sub(/^\d+_/, '').tap do |name|
      self.url_title = name.parameterize
    end
  end
  
  def order_scope
    page.try(:images)
  end
end
