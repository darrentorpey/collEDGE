require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should "be valid" do
    assert Event.new.valid?
  end
end
