class MessagesController < ApplicationController
  before_action :authenticate_user!, {only: [:create]}

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      @room = Room.find(params[:message][:room_id])
      @messages = @room.messages
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :user_id, :room_id).merge(user_id: current_user.id)
  end
end
