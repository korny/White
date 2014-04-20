class SectionsController < ApplicationController
  def reorder
    Section.update_order params[:ids].map(&:to_i)
    
    head :ok
  end
end
