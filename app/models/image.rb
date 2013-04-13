class Image < ActiveRecord::Base
  include OrderByPosition
  
  belongs_to :page, inverse_of: :images
  
  has_attached_file :picture, styles: -> (attachment) {
    {
      medium: "300x300>",
      thumb:  "100x100>",
    }
  }, :default_url => "/images/:style/missing.png"
  
  scope :has_picture, -> { where 'picture_file_name IS NOT NULL' }
  
  validates :page_id,        presence: true
  validates :title,          length: { maximum: 200 }
  validates :caption,        length: { maximum: 250 }
  validates :height, :width, numericality: { allow_nil: true }
  validates :picture,        :attachment_presence => true
  
  protected
  
  def order_scope
    page.try(:images)
  end
end
