# coding: utf-8
class ApplicationController < ActionController::Base
  
  protect_from_forgery
  helper_method :current_user

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Du måste vara inloggd!"
      redirect_to :root
      return false
    else
      return true
    end
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def format_errors(object)
    @array = Array.new
    object.errors.each do |attribute, message|
        @array << message
    end
    return @array
  end
end
