# coding: utf-8
class ApplicationController < ActionController::Base
  
  protect_from_forgery
  helper_method :current_user, :is_member

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
  
  def user_projects
    @all_projects = Project.all
    @projects = Array.new
    @all_projects.each do |project|
      if(project.users.where(["user_id = ?", current_user.id]).all.any? || project.user_id == current_user.id)
        @projects << project
      end
    end
    return @projects
  end
  
  def is_member(project_id)
    @project = Project.find(project_id)
    if @project.users.where(["user_id = ?", current_user.id]).all.any? || @project.user_id == current_user.id
        return @project
    else
      return false
    end
  end
  
  def format_errors(object)
    @array = Array.new
    object.errors.each do |attribute, message|
        @array << message
    end
    return @array
  end
end
