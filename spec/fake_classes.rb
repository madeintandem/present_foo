class Book; end
class AltBookPresenter < Presenter; end
class BookPresenter < Presenter; end

class BooksController < ActionController::Base

  def index
    books = [Book.new, Book.new, Book.new]
    present_many books
  end

  def show
    book = Book.new
    present book
  end

  def edit
    book = Book.new
    present book, AltBookPresenter
  end

end
