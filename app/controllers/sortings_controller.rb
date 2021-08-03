class SortingsController < ApplicationController
  def sort_by_updated_at
    @books = Book.all.order(updated_at: "DESC")
  end

  def sort_by_evaluation
    @books = Book.all.order(evaluation: "DESC")
  end
end
