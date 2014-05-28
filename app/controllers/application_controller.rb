class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user
    if !user_signed_in? 
      redirect_to '/', notice: "You must log in"
    end
  end
end
