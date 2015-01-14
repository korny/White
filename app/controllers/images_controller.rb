class ImagesController < ApplicationController
  before_action :set_section, only:   [:create, :reorder]
  before_action :set_page,    only:   [:create, :reorder]
  before_action :set_image,   except: [:create, :reorder]
  
  def create
    image = @page.images.build
    image.picture = params[:file]
    image.save!
    
    reload_page
  end
  
  def reorder
    @page.images.update_order params[:ids].map(&:to_i)
    
    head :ok
  end
  
  def update
    if @image.update image_params
      reload_page
    else
      error_fields = @image.errors.keys.map { |field| "input[name=\"image[#{field}]\"]" }
      
      render js: "$('#{error_fields.join ' '}', '.fancybox-title').addClass('error')"
    end
  end
  
  def destroy
    @image.destroy
    
    reload_page
  end
  
  private
  
  def set_section
    @section = Section.find_by!(url_title: params[:section_id])
  end
  
  def set_page
    @page = @section.pages.find_by!(url_title: params[:page_id])
  end
  
  def set_image
    @image = Image.find_by!(url_title: params[:id])
  end
  
  def image_params
    params.require(:image).permit(:page_id, :title, :caption, :height, :width, :position)
  end
end
