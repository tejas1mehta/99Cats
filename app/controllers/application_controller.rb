class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include SessionsHelper

  def sign_in(user)
    session_temp = Session.new({user_id: user.id, session_token: Session.create_session_token})
    session[:session_token] = session_temp.session_token
    session_temp.save!

    redirect_to cats_url
  end

  def to_root_if_curr_user
    redirect_to root_url if !!current_user
  end

end
