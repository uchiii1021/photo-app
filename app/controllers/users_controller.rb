class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.photos
    @currentUserRoom = UserRoom.where(user_id: current_user.id)
    @userRoom = UserRoom.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserRoom.each do |cu|
        @userRoom.each do |u|
          if cu.room_id == u.room_id
            @haveRoom = true
            @room_id = cu.room_id
          end
        end
      end
      unless @haveRoom
        @room = Room.new
        @user_room = UserRoom.new
      end
    end
  end
end