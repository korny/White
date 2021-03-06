class SessionsController < ApplicationController
  # FIXME: force_ssl
  
  skip_before_filter :verify_authenticity_token, only: :destroy
  skip_before_filter :login_required
  
  def create
    if user = authenticate_admin
      session[:user_id] = user.id
      
      reload_page
    else
      head :unauthorized
    end
  end
  
  def destroy
    reset_session
    
    reload_page
  end
  
  protected
  
  def authenticate_admin
    User.authenticate_admin(params[:password])
  end
  
  def reload
    render js: 'location.reload()'
  end
end
