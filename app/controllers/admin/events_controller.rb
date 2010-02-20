class Admin::EventsController < AdminController
  def index
    @events = Event.all
  end
end