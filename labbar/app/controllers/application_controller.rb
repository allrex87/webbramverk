class ApplicationController < ActionController::Base
  
  protect_from_forgery

  def confirm_logged_in
    unless session[:user_id]
      return false
    else
      return true
    end
    end
end
