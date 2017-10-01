class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_raven_context

  def set_supports
    @active_supports = Support.owner(current_user.id).active
    @archived_supports = Support.owner(current_user.id).archived
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

  private
    def set_raven_context
      Raven.user_context(id: current_user.try(:id), username: current_user.try(:username))
    end

end
