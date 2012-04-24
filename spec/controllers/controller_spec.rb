require "spec_helper"

class BooksController < ActionController::Base

  def index
    books = [Book.new, Book.new, Book.new]
    present_many books
    render "spec/app/views/books/test"
  end

  def show
    book = Book.new
    present book
    render "spec/app/views/books/test"
  end

  def edit
    book = Book.new
    present book, AltBookPresenter
    render "spec/app/views/books/test"
  end

end

class Book; end
class AltBookPresenter < Presenter; end
module ApplicationHelper; end

class BookPresenter < Presenter

  def edit_path
    controller.edit_book_path(:id => 1)
  end

end

describe BooksController do

  it "should have a present method" do
    controller.respond_to?(:present).should be_true
  end

  it "should have a present_many method" do
    controller.respond_to?(:present_many).should be_true
  end

  describe "/index" do

    before do
      get :index
      @presenters = assigns(:book_presenters)
    end

    it "assigns @book_presenters" do
      @presenters.should_not be_nil
      @presenters.should be_kind_of(Array)
    end

  end

  describe "/show" do

    before do
      get :show, :id => 1
      @presenter = assigns(:book_presenter)
    end

    it "assigns @book_presenter" do
      @presenter.should_not be_nil
      @presenter.should be_kind_of(BookPresenter)
    end

    it "@book_presenter has a host property" do
      @presenter.controller.should == controller
    end

    it "@book_presenter has a controller property (alias for host in Rails)" do
      @presenter.host.should == controller
    end

    it "@book_presenter has access to routes through the controller property" do
      @presenter.edit_path.should == "/books/1/edit"
    end

  end

  describe "/edit" do

    before do
      get :edit, :id => 1
      @presenter = assigns(:alt_book_presenter)
    end

    it "assigns @alt_book_presenter (and is the correct type)" do
      @presenter.should_not be_nil
      @presenter.should be_kind_of(AltBookPresenter)
    end

  end

end
