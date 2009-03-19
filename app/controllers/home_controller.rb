class HomeController < ApplicationController
  def index
    logged_in? ? redirect_to('/sso/login') : render
  end
end
