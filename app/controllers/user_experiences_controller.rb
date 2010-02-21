class UserExperiencesController < ApplicationController
  before_filter :get_user

  helper :experience

  def user
  end

  private
  def get_user
    @user = User.find_by_id(params[:id])
  end
end