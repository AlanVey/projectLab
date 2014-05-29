class HomeController < ApplicationController
  
  before_filter :user_signed_in

  def index
  end
end
