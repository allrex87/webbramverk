# coding: utf-8
class TicketsController < ApplicationController
  
   before_filter :confirm_logged_in, :load_project
  
  def show
    @ticket = @project.tickets.find(params[:id])
  end
  
  def new
    @ticket = @project.tickets.new
  end
  
  def create

    @ticket = @project.tickets.new(params[:ticket])
    @ticket.user_id = current_user.id
    if @ticket.save
      flash[:notice] = "Ticketen är skapad!"
      redirect_to project_ticket_path(@project,@ticket)
    else
      flash[:alert] = format_errors(@ticket)
      render :action => "new"
    end
  end
  
  def edit
     @ticket = @project.tickets.find(params[:id])
  end
  
  def update
    @ticket = @project.tickets.find(params[:id])
    if(current_user.id == @ticket.user_id)
      #smidigt att uppdatera alla attribut samtidigt
      if  @ticket.update_attributes(params[:ticket])
        flash[:notice] = "Ticketen är redigerad!"
        redirect_to project_ticket_path(@project,@ticket)
      else
        flash[:alert] = format_errors(@ticket)
        render :action => "edit"
      end
    else
      flash[:alert] = "Du är inte authoriserad för denna ticket!"
    end
  end
  
  def destroy
    #destroy plockkar bort tillhörande reltioner
    @ticket = @project.tickets.find(params[:id])
    if(current_user.id == @ticket.user_id)
      @ticket.destroy
        flash[:notice] = "Ticketen är borttaget!"
        redirect_to project_path(@project)
    else
      flash[:alert] = "Du är inte authoriserad för denna ticket!"
    end
  end
  
  def load_project
    @project = Project.find(params[:project_id])
  end
  
end
