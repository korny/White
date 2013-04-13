module ApplicationHelper
  def sidebar_sections
    Section.includes(:pages)
  end
end
