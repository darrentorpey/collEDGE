class UserExperiencesController < ApplicationController
  before_filter :get_user

  def user
    @top_line = 'Experience something&hellip;'
  end

  private
  def get_user
    @user = User.find_by_id(params[:id])
  end
end