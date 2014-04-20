class PagesController < ApplicationController
  skip_before_filter :login_required, only: [:index, :show]
  
  before_action :set_section, only: [:show, :create, :reorder, :update, :destroy]
  before_action :set_page,    only: [:show,                    :update, :destroy]
  
  def index
    @section = Section.welcome_section
    @page    = @section.welcome_page
    
    render :show
  end
  
  def show
  end
  
  def create
    @page = @section.pages.create!(page_params)
  end
  
  def reorder
    @section.pages.update_order params[:ids].map(&:to_i)
    
    head :ok
  end
  
  def update
    @page.update!(page_params)
  end
  
  def destroy
    @page.destroy!
  end
  
  private
  
  def set_section
    @section = Section.find_by!(url_title: params[:section_id])
  end
  
  def set_page
    @page = @section.pages.find_by!(url_title: params[:id])
  end
  
  def page_params
    params.require(:page).permit(:title, :images_zoom_factor, :text).tap do |page_params|
      page_params[:text].encode! universal_newline: true if page_params[:text]
    end
  end
end
