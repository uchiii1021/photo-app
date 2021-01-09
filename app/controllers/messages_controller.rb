class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
    if UserRoom.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      respond_to do |format|
        if @message.save
          format.html {room_url(@message.room_id)}
          format.js { render :index }
        else
          format.html {room_url(@message.room_id)}
          format.js { render :index }
        end
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message_content, :room_id).merge(user_id: current_user.id)
  end
end
