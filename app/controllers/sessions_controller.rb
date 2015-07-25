class SessionsController < ApplicationController

skip_before_filter :authorize
layout "session"

def new 
  @user = User.new
end

def create
  @user = User.new user_params
  record = User.find_by name: params[:user][:name]
  if record == nil then
    @user.errors.add "name","this name is wrong"
    render :action => 'new'
  else
    if !record.authenticate params[:user][:password] then
      @user.errors.add "password","this password is wrong"
      render :action => 'new'
    else
      @user = record
      session[:user_id] = @user.id
      redirect_to :controller => "notes", :action => "welcome"
    end
  end
end

def destroy
  session[:user_id] = nil
  redirect_to  :action => "new"
end

private
def user_params
  params.require(:user).permit(:name, :password)
end



end
