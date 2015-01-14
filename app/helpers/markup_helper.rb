module MarkupHelper
  def markdown text
    text.blank? ? '' : RDiscount.new(text).to_html.html_safe
  end
end
