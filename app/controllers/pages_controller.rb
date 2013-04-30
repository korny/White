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
    @page.images_zoom_factor = params[:images_zoom_factor]
    @page.save!
    
    reload_page
  end
  
  private
  
  def set_section
    @section = Section.find_by!(url_title: params[:section_id])
  end
  
  def set_page
    @page = @section.pages.find_by!(url_title: params[:id])
  end
end
