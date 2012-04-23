require "spec_helper"

class BooksController < ActionController::Base

  def index
    books = [Book.new, Book.new, Book.new]
    present_many books
    render "spec/app/views/books/index"
  end

  def show
    book = Book.new
    present book
    render "spec/app/views/books/show"
  end

end

class Book

end

class BookPresenter < Presenter

end

describe BooksController do

  it "should have a present method" do
    controller.respond_to?(:present).should be_true
  end

  it "should have a present_many method" do
    controller.respond_to?(:present_many).should be_true
  end

  describe "/index" do

    it "assigns @book_presenters" do
      get :index
      assigns(:book_presenters).should_not be_nil
    end

  end

  describe "/show" do

    before do
      get :show, :id => 1
      @presenter = assigns(:book_presenter)
    end

    it "assigns @book_presenter" do
      @presenter.should_not be_nil
    end

    it "@book_presenter has a request property" do
      @presenter.request.should == controller.request
    end

  end

end
