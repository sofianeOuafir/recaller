class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_supports

  def set_supports
    @supports = Support.all
  end
end
