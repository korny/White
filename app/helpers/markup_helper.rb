module MarkupHelper
  def markdown text
    text.blank? ? '' : Kramdown::Document.new(text.gsub(/(?<!\n)\n(?!\n)/, "\n<br>")).to_html.html_safe
  end
end
