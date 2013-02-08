class SessionsController < ApplicationController
  
  layout "start"
  before_filter :confirm_logged_in, :except => [ :new, :create]
      def index
     
    end
  
    def new
     
    end

    def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:notice] = "Fel uppgifter"
        redirect_to :root
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to log_in_path, :notice => "Logged out"
  end
  
end