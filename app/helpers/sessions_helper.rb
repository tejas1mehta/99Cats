module SessionsHelper
  def current_user
    @current_user ||= Session.find_by_session_token(session[:session_token]).try(:user)
  end
end
