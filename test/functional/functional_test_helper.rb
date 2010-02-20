require File.join(File.dirname(__FILE__), "..", "test_helper")

module HelperFunctionalInstanceMethods

  def login_pb_user(user = nil)
    setup_session
    
    # ActionController::TestCase gives us an ActionController instance of the
    # appropriate controller (inferred by the name of the test class), and instances
    # of TestRequest and TestResponse in @controller, @request and @response
    # (respectively) just like an 'old-fashioned' functional test
    #
    # Access session through @controller.session
    @user = user ? user : default_user
    #@controller.session[:user] = @user.id
    @controller.session[:user] = @user.id
  end

  def ensure_logged_out
    return unless @controller && @controller.session
    @controller.session[:user] = nil
  end

  def setup_session
    # Hackery to get a TestSession instance setup in @controller.session if it
    # isn't already
    
    # sigh.  dont ask.
    @controller.session = @controller.session || @request.session || ActionController::TestSession.new 

    @request.session_options ||= {}
  end

  def setup_admin_session
    setup_session
    #@controller.session[:admin_authenticated] = true
    @controller.session[:admin_authenticated] = true
  end

  def setup_for_oriental_trading
    Site::Configuration.load(File.join(RAILS_ROOT, 'config', 'sites', 'orientaltrading.yml'))
  end

  def assert_not_found_page
    assert_response 404
    assert_template "#{RAILS_ROOT}/public/deleted_object.html"
  end

  def assert_analytics
    assert_template :partial => 'partners/_analytics_head'
    assert_template :partial => 'partners/_analytics_body'
  end

  def yahoo_landing_tag_params
    { :tag => 'script', :attributes => { :src => 'http://adreadytractions.com/rt/123811?p=721'} }
  end
  
  def yahoo_conversion_tag_params
    { :tag => 'script', :attributes => { :src => 'http://adreadytractions.com/pt/123811/?h=dfc34ac94f475ad22325' } }
  end

  def adwords_conversion_tag_params
    { :tag => 'img', :attributes => { :src => 'http://www.googleadservices.com/pagead/conversion/1067096761/imp.gif?value=1&label=default&script=0' } }
  end
  
  def google_affiliate_conversion_tag_params(event)
    { :tag => 'img', :attributes => { :src => %r{https://clickserve.cc-dt.com/link/action\?.*oid=#{event.event_key}} } }
  end
  
  def fetchback_landing_tag_params
    { :tag => 'iframe', :attributes => { :src => /fetchback/ }}
  end

  def fetchback_success_tag_params(event)
    { :tag => 'iframe', :attributes => { :src => /fetchback.*#{event.event_key}/ }}
  end

  def stub_out_honeypot
      r = PunchbowlWebServices::Core::Remote
      category_params = {  :id => '1', :name => 'some cat', :description => 'yes', :funnel_image => '',
                           :sample_vendor_images_code_name => 'code_name',
                           :blurb => 'texty wexty', :slug => 'nice', :party_slug => 'c-nice',
                           :title_tag => 'DJ title tag', :meta_description => 'this is some metashizzle',
                           :state_meta_description => 'yes', :city_meta_description => 'yes',
                           :meta_keywords => 'one, two, three, dj, keywords',
                           :logos => ['one', 'two', 'three'],
                           :parent_category_id => nil,
                           :child_category_ids => nil,
                           :state_blurb => 'state blurby!', :one_liner => 'one line of text!',
                           :city_blurb => 'city blurb thingy!',
                           :city_meta => 'city specific metadesc', :state_meta => 'state specific metadesc' }
      @category_stub = stub('Cat', category_params)
      @cat_stub_two = stub('Cat2', category_params.merge({ :id => '2', :name => 'Venues & Locations', :slug => 'also-nice' }))

      @region_stub = stub('Region', :name => 'boston', :state_abbreviation => 'ma', :blurb => 'nice', :slug => 'r-whoa')
      
      @city_stub = stub('City', :name => 'Boston', :state_abbreviation => 'MA', :slug => 'boston', 
                               :region_name => 'boston', :blurb => 'whoa', :meta_description => 'this city is ok')
      
      @state_stub = stub('State', :name => 'Mass', :abbreviation => 'MA', :blurb => 'whoa', :slug => 'ma-mass',
                        :cities => [@city_stub, @city_stub],
                        :find_region => @region_stub, :region_cities => [@city_stub, @city_stub],
                        :city => @city_stub, :regions => [@region_stub, @region_stub],
                        :meta_description => 'this state is acceptable' )
      
      @raw_vendor_stub = stub('SomeVendor', :id => 1, :name => 'ryan\'s stuff',
                              :zip_code => '01585', :email => 'ryan@angilly.com',
                              :phone_number => '508.579.7453', :city => @city_stub.name,
                              :state => @city_stub.state_abbreviation,
                              :slug => 'ryan-s-stuff',
                              :category_ids => @category_stub.id.to_s)
      
      @vendor_stub = stub('Vendor', :meta => stub('wp', :current_page => 1, :total_pages => 10, :previous_page => nil,
                                                 :next_page => 2, :total_entries => 30),
                         :search_results => [@raw_vendor_stub])

      @vendor_settings = stub('VendorSetting', :title_tag => 'generic title tag',
                              :meta_keywords => 'one, 2, three', :meta_description => 'hi there buddy')

      r::BoilerPlate.stubs(:first).returns @vendor_settings
      r::Category.stubs(:all).returns [@category_stub, @cat_stub_two, @category_stub]
      r::Category.stubs(:cached_all).returns [@category_stub, @cat_stub_two, @category_stub]
      r::State.stubs(:all).returns [@state_stub, @state_stub, @state_stub, @state_stub]
      r::State.stubs(:cached_all).returns [@state_stub, @state_stub, @state_stub, @state_stub]
      r::City.stubs(:all).returns [@city_stub, @city_stub]
      r::City.stubs(:nearby).returns stub('nearby', :cities => [@city_stub, @city_stub])
      r::Vendor.stubs(:all).returns [@vendor_stub]
      r::Vendor.stubs(:find).returns @raw_vendor_stub
      r::Region.stubs(:all).returns [@region_stub, @region_stub]
      r::Category.stubs(:search).returns @category_stub 
      r::Category.stubs(:cached_category).returns @category_stub 
      r::State.stubs(:search).returns @state_stub
      r::State.stubs(:cached_state).returns @state_stub
      r::City.stubs(:search).returns @city_stub
      r::Vendor.stubs(:search).returns @vendor_stub
      r::Region.stubs(:search).returns @region_stub
  end
end

module HelperFunctionalClassMethods

  def logged_out_user(&block)
    context "For a non-logged in user" do
      setup do
        # nothing
      end
      
      context '' do
        block.bind(self).call
      end
    end
  end

  def logged_in_user(user = nil, &block)
    context "a logged in user" do
      setup do
        login_pb_user(user)
      end
      
      context '' do
        block.bind(self).call
      end
    end
  end

  def should_redirect_if_not_logged_in(action, r_path = nil)
    should "require login for '#{action}' action" do
      ensure_logged_out
      get action
      if r_path
        assert_redirected_to r_path
      else
        assert_response :redirect
      end
    end
  end

  def should_require_login(actions)
    actions = [actions] if actions.kind_of?(Symbol)
    actions.each do |action|
      should_redirect_if_not_logged_in(action, '/signin')
    end
  end

  def should_redirect_for_cancelled_event(actions, path = '/dashboard')
    actions = [actions] if actions.kind_of?(Symbol)
    actions.each do |action|
      should "redirect to '#{path}' when a logged-in user calls '#{action}' with a cancelled event" do
        @user = Factory :user, :email => 'LOWERcase@gmail.com'
        login_pb_user @user
        @event = Factory(:event, :user_id => @user.id)
        @event.trigger_cancelled
        get action, :event_key => @event.event_key
        assert_redirected_to path
      end
    end
  end

  def should_render_partial(partial, count = 1)
    should "render partial #{partial.inspect}" do
      assert_template :partial => partial.to_s, :count => count  
    end
  end

  def with_get(action, options = {}, &block)
    context "Getting #{action} with #{options.inspect}" do
      setup { get action, options }

      should_respond_with :success

      context '' do
        instance_eval &block
      end
    end
  end

end

# We can mix in our own instance methods for use inside setup blocks
# and should blocks
ActionController::TestCase.send(:include, HelperFunctionalInstanceMethods)


# And we can mix in our own macros for use outside should blocks (and inside
# or outside context blocks)
ActionController::TestCase.extend HelperFunctionalClassMethods

module SmartMock

  def dumb_mock(factory_type, methods = [:find, :find_by_id], value = nil)
    methods.each do |m|
      classize(factory_type).stubs(m).returns value
    end
    instance_variable_set("@#{factory_type}", value)
  end

  def smart_mock(factory_type, keys = {:id => 1})
    object = Factory.build factory_type

    keys.each do |k,v|
      object.send "#{k.to_s}=", v
      object.class.stubs("find_by_#{k}".to_sym).returns(object)
    end

    object.class.stubs(:find).returns(object) 

    return instance_variable_set("@#{factory_type}", object)
  end

  def create_mock(factory_type, keys = {:id => 1})
    klass = classize(factory_type)
    sm = smart_mock(factory_type, keys)
    sm.stubs(:save).returns true
    klass.stubs(:create).returns(sm)
    klass.stubs(:new).returns(sm)
  end

  def classize(sym)
    sym.to_s.camelize.constantize
  end
end

module ImportTests
  module InstanceMethods
    def flash_keys
      [:invalid, :duplicate, :not_allowed, :bounced, :success, :invalid_count,
        :duplicate_count, :not_allowed_count, :bounced_count, :success_count]
    end
  end

  module ClassMethods
    def should_add_a_list &add_a_list_block
      logged_in_user do
        context "with an event" do
          setup do
            @email_list = "ryan@angilly.com; ryan <ryan1@angilly.com>; \n some one else <else@gmail.com>"
            @emails_in_list = ['ryan@angilly.com', 'ryan1@angilly.com', 'else@gmail.com']
            @event = Factory :event, :user => @user
          end

          should "be able to add a list with POST" do
            post :add_a_list, :event_key => @event.event_key, :add_a_list => @email_list
            assert_redirected_to 'javascript:window.location.reload()'
            add_a_list_block.bind(self).call(@emails_in_list) if add_a_list_block
            assert_same_elements flash[:import_results].keys, flash_keys
            assert_equal @emails_in_list.size, flash[:import_results][:success].size
          end

          should "be able to add a list with XHR POST" do
            xhr :post, :add_a_list, :event_key => @event.event_key, :add_a_list => @email_list
            assert_template 'import_contacts/_setup_add_guests_stack.js.rjs'
            add_a_list_block.bind(self).call(@emails_in_list) if add_a_list_block
            assert_same_elements flash[:import_results].keys, flash_keys
            assert_equal @emails_in_list.size, flash[:import_results][:success].size 
          end
        end
      end
    end

    def should_import_from_file &import_block
      should_eventually "importing contacts from a file" 
    end

    def should_import_from_previous_event &import_block
      logged_in_user do
        context "with two events" do
          setup do
            @previous_event = Factory :event, :user => @user
            4.times { |n| Factory :yes_sent_invite, :event => @previous_event }
            @previous_invite_emails = @previous_event.invites.sent.map(&:email).sort

            @event = Factory :event, :user => @user
          end

          should "be able to import from previous with POST" do
            post :import_previous_event, :event_key => @event.event_key, :id => @previous_event.id
            assert_redirected_to 'javascript:window.location.reload()'
            import_block.bind(self).call(@previous_invite_emails) if import_block
            assert_same_elements flash[:import_results].keys, flash_keys
            assert_equal @previous_invite_emails.size, flash[:import_results][:success].size 
          end

          should "be able to add a list with XHR POST" do
            xhr :post, :import_previous_event, :event_key => @event.event_key, :id => @previous_event.id
            assert_template 'import_contacts/_setup_add_guests_stack.js.rjs'
            import_block.bind(self).call(@previous_invite_emails) if import_block
            assert_same_elements flash[:import_results].keys, flash_keys
            assert_equal @previous_invite_emails.size, flash[:import_results][:success].size
          end
        end
      end
    end
  end
end

ActionController::TestCase.send :include, ImportTests::InstanceMethods
ActionController::TestCase.extend ImportTests::ClassMethods
ActionController::TestCase.send(:include, SmartMock)