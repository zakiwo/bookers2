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
    @books = @book_user.books.all
    @new_book = Book.new
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
