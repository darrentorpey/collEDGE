module PathHelper
  def user_experiences_path(user)
    url_for(:controller => 'user_experiences', :action => 'user', :id => user.id)
  end
end