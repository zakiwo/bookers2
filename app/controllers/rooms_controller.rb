class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :follow_each_other, {only: [:show]}

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(entry_params)
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def entry_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

  def follow_each_other
    Room.find(params[:id]).entries.each do |e|
      if e.user != current_user
        @another_user = e.user
      end
    end
    unless current_user.following?(@another_user) && @another_user.following?(current_user)
      redirect_to books_path
    end
  end
end
