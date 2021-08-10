class SearchController < ApplicationController

  def search
    @keyword = params[:keyword]
    @category = params[:category]
    search_method = params[:search_method]
    if @category == "Book"
      if search_method == "perfect_match"
        @search = Book.where(["title like? OR body like?", "#{@keyword}","#{@keyword}"])
      elsif search_method == "partial_match"
        @search = Book.where(["title like? OR body like?", "%#{@keyword}%", "%#{@keyword}%"])
      elsif search_method == "forward_match"
        @search = Book.where(["title like? OR body like?", "#{@keyword}%", "#{@keyword}%"])
      elsif search_method == "backwoad_match"
        @search = Book.where(["title like? OR body like?", "%#{@keyword}", "%#{@keyword}"])
      end
    elsif @category == "User"
      if search_method == "perfect_match"
        @search = User.where(["name like?", "#{@keyword}"])
      elsif search_method == "partial_match"
        @search = User.where(["name like?", "%#{@keyword}%"])
      elsif search_method == "forward_match"
        @search = User.where(["name like?", "#{@keyword}%"])
      elsif search_method == "backwoad_match"
        @search = User.where(["name like?", "%#{@keyword}"])
      end
    end
  end

  def search_category
    @category = params[:category]
    @books = Book.where(["category like?", "%#{@category}%"])
  end
end
