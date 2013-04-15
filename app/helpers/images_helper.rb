module ImagesHelper
  def image_fancybox_title
    [
      image.title,
      "#{image.height}x#{image.width}cm — #{image.caption}"
    ].join('<br>')
  end
end
