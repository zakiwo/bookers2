class UsersController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}

  def ensure_current_user
    user = User.find(params[:id])
    if current_user.id != user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user)
    end
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @new_book = Book.new
  end

  def show
    @book_user = User.find(params[:id])
    @today_posts = @book_user.post_counts(Time.current.beginning_of_day..Time.current)
    @yesterday_posts = @book_user.post_counts(Time.current.ago(1.days).all_day)
    @this_week_posts = @book_user.post_counts(Time.current.ago(6.days).beginning_of_day..Time.current)
    @last_week_posts = @book_user.post_counts(Time.current.ago(2.weeks).beginning_of_day..Time.current.ago(1.weeks).end_of_day)
    if @yesterday_posts != 0
      @day_comparison = (@today_posts.to_f / @yesterday_posts.to_f * 100)
    else
      @day_comparison = 0
    end
    if @last_week_posts != 0
      @week_comparison = (@this_week_posts.to_f / @last_week_posts.to_f * 100)
    else
      @week_comparison = 0
    end
    @books = @book_user.books.all
    @new_book = Book.new
    #自分のエントリー
    @currentUserEntry = Entry.where(user_id: current_user.id)
    #相手のエントリー
    @userEntry = Entry.where(user_id: @book_user.id)
    if @book_user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "you have updated user successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
