class Image < ActiveRecord::Base
  belongs_to :gallery
  
  has_attached_file :picture, styles: -> (attachment) {
    {
      medium: "300x300>",
      thumb:  "100x100>",
    }
  }, :default_url => "/images/:style/missing.png"
end
