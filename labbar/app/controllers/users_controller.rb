class UsersController < ApplicationController
  
    layout "start"
  def new
    @user_to_create = User.new
  end
  
   def create
    @user_to_create = User.new(params[:user])
    if @user_to_create.save
      begin
        flash[:notice] = "user is created"
        redirect_to :root
      end
    else
      #valideringfel hittas i Project.errors
      #flash[:notice] = User.errors
    end
  end

end
