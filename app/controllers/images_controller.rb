class ImagesController < ApplicationController
  before_action :set_section, only: [:create, :reorder]
  before_action :set_page,    only: [:create, :reorder]
  before_action :set_image,   only: [:update, :destroy]
  
  def create
    image = @page.images.build
    image.picture = params[:file]
    image.save!
    
    reload_page
  end
  
  def reorder
    ids = params[:ids].map(&:to_i).uniq
    if ids.size == @page.images.size
      @page.update_images_order ids
    end
    
    head :ok
  end
  
  def update
    if @image.update image_params
      reload_page
    else
      render js: "$('#{@image.errors.keys.map { |field| "input[name=\"image[#{field}]\"]" }.join ' '}', '.fancybox-title').addClass('error')"
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
