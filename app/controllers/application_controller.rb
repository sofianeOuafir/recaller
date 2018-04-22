class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_raven_context

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  private

  def set_raven_context
    Raven.user_context(id: current_user.try(:id),
                       username: current_user.try(:username))
  end
end
