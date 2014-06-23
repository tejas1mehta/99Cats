class SessionsController < ApplicationController
  before_action :to_root_if_curr_user, only: :new


  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:session][:user_name], params[:session][:password])
    if @user
      sign_in(@user)
    else
      flash[:errors] = ["Incorrect Username/Password"]
      redirect_to(new_session_url)
    end
  end

  def destroy
    Session.find_by_session_token(session[:session_token]).destroy #delete!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
