class HomeController < ApplicationController
  def index
    @supports = Support.all
  end
end
