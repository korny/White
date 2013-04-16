module PagesHelper
  def welcome_page
    @welcome_page ||= Section.welcome_section.welcome_page
  end
end
