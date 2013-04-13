class ImagesController < ApplicationController
  before_action :set_page,  only: [:create]
  before_action :set_image, only: [:update, :destroy]
  
  def create
    image = @page.images.create!(picture: params[:file])
    
    render json: {
      url: image.picture.url(:thumb)
    }
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
  
  def set_page
    @page = Page.find_by!(url_title: params[:page_id])
  end
  
  def set_image
    @image = Image.find_by!(id: params[:id])
  end
  
  def image_params
    params.require(:image).permit(:page_id, :title, :caption, :height, :width, :position)
  end
end
