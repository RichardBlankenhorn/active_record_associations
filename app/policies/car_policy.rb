class CarPolicy < ApplicationPolicy
  def edit?
    user_is_logged_in?
  end

  def new?
    user_is_logged_in?
  end

  def destroy?
    user_is_logged_in? && user.admin?
  end
end
