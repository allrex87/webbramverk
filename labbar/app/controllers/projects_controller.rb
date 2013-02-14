# coding: utf-8
class ProjectsController < ApplicationController
  
  before_filter :confirm_logged_in
  
  def index
    user_projects
  end
  
  def search
     @sprojects = Project.search(params[:search]) if params[:search]
     render "index"
  end
  
  def show
    @project = is_member(params[:id])
    if !@project
      flash[:alert] = "Du är inte authoriserad för detta projektet!"
      redirect_to projects_path()
    end
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.users = User.where(["id in (?)", params[:members]]).all
    @project.user_id = current_user.id
    if @project.save
      flash[:notice] = "Projektet är skapat!"
      redirect_to project_path(@project)
    else
      flash[:alert] = format_errors(@project)
      render :action => "new"
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if(current_user.id == @project.user_id)
      #smidigt att uppdatera alla attribut samtidigt
      @project.users = User.where(["id in (?)", params[:members]]).all
      if @project.update_attributes(params[:project])
        flash[:notice] = "Projektet är redigerat!"
        redirect_to project_path(@project)
      else
        flash[:alert] = format_errors(@project)
        render :action => "edit"
      end
    else
      flash[:alert] = "Du är inte authoriserad för detta projektet!"
      redirect_to project_path()
    end
  end
  
  def destroy
    #destroy plcokar bort tillhörande reltioner
    @project = Project.find(params[:id])
    if(current_user.id == @project.user_id)
      @project.destroy
      flash[:notice] = "Projektet är borttaget!"
      redirect_to projects_path
    else
      flash[:alert] = "Du är inte authoriserad för detta projektet!"
    end
  end
end
