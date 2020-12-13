class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @photos = current_user.photos
  end
end