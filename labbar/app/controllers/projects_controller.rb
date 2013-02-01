class ProjectsController < ApplicationController
  
  def index
     @projects = Project.all
  end
  
  def show
    @Project = Project.find(params[:id])
  end
  
  def new
    @project_to_create = Project.new
  end
  
  def create
    @project_to_create = Project.new(params[:project])
    if @project_to_create.save
      redirect_to projects_path(@project_to_create)
    else
      #valideringfel hittas i Project.errors
      redirect_to projects_path
    end
  end
  
  #GET /pojects/1/edit
  def edit
    #id parametern får vi med via url:en
    @Project = Project.find(params[:id])
  end
  
  #PUT /pojects/1
  def update
    @Project = Project.find(params[:id])
    #smidigt att uppdatera alla attribut samtidigt
    if @Project.update_attributes(params[:project])
      redirect_to projects_path
    else
      #valideringfel hittas i Project.errors
      render :action => "edit"
    end
  end
  
  def destroy
    #destroy plcokar bort tillhörande reltioner
    @Project = Project.find(params[:id])
    @Project.destroy
    redirect_to projects_path
  end
end
