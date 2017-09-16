class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_supports
  def index
  end
end
