class SectionsController < ApplicationController
  before_filter :set_section, except: [:create, :reorder]
  
  def create
    Section.create!(section_params)
    
    reload_page
  end
  
  def reorder
    Section.update_order params[:ids].map(&:to_i)
    
    head :ok
  end
  
  def update
    @section.update!(section_params)
    
    reload_page
  end
  
  def destroy
    @section.destroy
    
    reload_page
  end
  
  private
  
  def set_section
    @section = Section.find_by!(url_title: params[:id])
  end
  
  def section_params
    params.require(:section).permit(:title)
  end
end
