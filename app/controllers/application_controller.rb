class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_supports;
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_supports
    @supports = Support.all
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
