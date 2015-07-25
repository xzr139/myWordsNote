class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize
  
#  def current_user
#    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
#  end
#  helper_method :current_user

  private
  def authorize
    if !User.find_by id: session[:user_id]      
      redirect_to :action => "new", :controller => "sessions"
    end
  end
  
end
