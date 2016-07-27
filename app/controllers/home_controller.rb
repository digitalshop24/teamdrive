class HomeController < ApplicationController

  def index
    @terrapods = Terrapod.all
  end

end
