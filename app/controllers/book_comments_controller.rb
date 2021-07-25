class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    if @comment.save
      redirect_to book_path(book)
    else
      @book = Book.find(params[:book_id])
      @user = User.find(@book.user_id)
      @new_book = Book.new
      render 'books/show'
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
