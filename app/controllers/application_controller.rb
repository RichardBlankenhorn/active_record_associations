class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  protect_from_forgery with: :exception

  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Access not allowed'
    redirect_to(request.referrer || root_path)
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  rescue ActiveRecord::RecordNotFound
    session.delete(:id)
    nil
  end
end
