class Admin::EventsController < AdminController
  layout 'admin'

  def index
    @events = Event.all
  end
end