class PagesController < ApplicationController
  before_action :set_section, :only => :show
  before_action :set_page,    :only => :show
  
  def index
    @section = Section.welcome_section
    @page    = @section.welcome_page
    
    render :show
  end
  
  def show
  end
  
  private
  
  def set_section
    @section = Section.find_by!(url_title: params[:section_id])
  end
  
  def set_page
    @page = @section.pages.find_by!(url_title: params[:id])
  end
end
