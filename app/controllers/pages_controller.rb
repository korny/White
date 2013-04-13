class PagesController < ApplicationController
  before_action :set_page, :only => :show
  
  def index
    @page = Page.welcome_page
    
    render :show
  end
  
  def show
  end
  
  private
  
  def set_page
    @page = Page.find(params[:id])
  end
end
