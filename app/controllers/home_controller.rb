class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @supports = current_user.supports.active
  end
end
