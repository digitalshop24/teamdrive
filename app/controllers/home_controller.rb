class HomeController < ApplicationController
 
  def index
    @terrapods = Terrapod.all
    @events = Event.all 
  end

  def show_event 
  		#binding.pry
  		@event = Event.find(params[:id])
  end

  def show_map

  end

  def show_terrapod
  	@terrapod_id = Terrapod.find(params[:id])
  end
  
end




