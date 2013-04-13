class ImagesController < ApplicationController
  before_action :set_section, only: [:create, :reorder]
  before_action :set_page,    only: [:create, :reorder]
  before_action :set_image,   only: [:update, :destroy]
  
  def create
    image = @page.images.create!(picture: params[:file])
    
    render json: {
      url: image.picture.url(:thumb)
    }
  end
  
  def reorder
    ids = params[:ids].map(&:to_i).uniq
    if ids.size == @page.images.size
      @page.update_images_order ids
    end
    
    head :ok
  end
  
  def update
    @image.update! image_params
    
    render head: :ok
  end
  
  def destroy
    @image.destroy
    
    render head: :ok
  end
  
  private
  
  def set_section
    @section = Section.find_by!(url_title: params[:section_id])
  end
  
  def set_page
    @page = @section.pages.find_by!(url_title: params[:page_id])
  end
  
  def set_image
    @image = Image.find_by!(id: params[:id])
  end
  
  def image_params
    params.require(:image).permit(:page_id, :title, :caption, :height, :width, :position)
  end
end
