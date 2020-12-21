class RoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    @room = Room.create
    @joinCurrentUser = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    @joinUser = UserRoom.create(join_room_params)
    redirect_to room_url(@room)
  end

  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @user_rooms = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def join_room_params
    params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end
