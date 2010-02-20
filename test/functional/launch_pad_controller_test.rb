require File.join(File.dirname(__FILE__), 'functional_test_helper')

class LaunchPadControllerTest < ActionController::TestCase
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
end