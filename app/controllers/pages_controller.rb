class PagesController < ApplicationController
  skip_before_filter :login_required
  
  before_action :set_section, :only => [:show, :update]
  before_action :set_page,    :only => [:show, :update]
  
  def index
    @section = Section.welcome_section
    @page    = @section.welcome_page
    
    render :show
  end
  
  def show
  end
  
  def update
    @page.update! page_params
    
    reload_page
  end
  
  private
  
  def set_section
    @section = Section.find_by!(url_title: params[:section_id])
  end
  
  def set_page
    @page = @section.pages.find_by!(url_title: params[:id])
  end
  
  def page_params
    params.require(:page).permit(:images_zoom_factor, :text).tap do |page_params|
      page_params[:text].encode! universal_newline: true if page_params[:text]
    end
  end
end
