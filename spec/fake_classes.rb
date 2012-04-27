class Book

  attr_accessor :title, :author, :isbn, :publish_date

  def initialize(*attrs)
    attrs.each { |k,v| self.send("#{k}=".to_sym, v) }
  end

end

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

class Product; end

class ProductPresenter < Presenter

  attr_accessor :attr1, :attr2, :attr3

  def initialize(obj, arg1, arg2, arg3)
    @attr1 = arg1
    @attr2 = arg2
    @attr3 = arg3
    super(obj)
  end

end

class ProductsController < ActionController::Base

  def show
    product = Product.new
    present product, "foo", "bar", "baz"
  end

end
