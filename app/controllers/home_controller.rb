class HomeController < ApplicationController  
  before_filter :user_signed_in

  def index
  end

  private
  
    def user_signed_in
      redirect_to projects_path if user_signed_in?
    end
end
