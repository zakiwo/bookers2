class BooksController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}

  def ensure_current_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end

  # 過去一週間のいいねを取得
  def a_week_favorite(favorite)
    range = Time.current.ago(6.days)..Time.current
    return favorite.where(created_at: range)
  end

  def index
    @user = User.find(current_user.id)
    @new_book = Book.new
    @books = Book.all.sort_by{|book| a_week_favorite(book.favorites).count}.reverse
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "you have created book successfully"
      redirect_to book_path(@new_book)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def show
    book = Book.find(params[:id])
    impressionist(book, nil, unique: [:session_hash.to_s])
    @user = User.find(book.user_id)
    @new_book = Book.new
    @comment = BookComment.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "you have updated book successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book= Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category)
  end
end
