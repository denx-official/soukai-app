class EventsController < ApplicationController
  
  def index
    Event.check_events()
  end
  
end
