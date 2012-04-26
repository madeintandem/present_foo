require "spec_helper"

describe "Controllers" do

  let(:books_controller) { BooksController.new }
  let(:products_controller) { ProductsController.new }

  it "should have a present method" do
    books_controller.respond_to?(:present).should be_true
  end

  it "should have a present_many method" do
    books_controller.respond_to?(:present_many).should be_true
  end

  describe "#present_many" do

    before do
      books_controller.index
      @presenters = books_controller.instance_variable_get(:@book_presenters)
    end

    it "assigns @book_presenters" do
      @presenters.should_not be_nil
      @presenters.should be_kind_of(Array)
    end

  end

  describe "#present" do

    before do
      books_controller.show
      @presenter = books_controller.instance_variable_get(:@book_presenter)
    end

    it "assigns @book_presenter" do
      @presenter.should_not be_nil
      @presenter.should be_kind_of(BookPresenter)
    end

    it "@book_presenter has a presenting_object property" do
      @presenter.presenting_object.should == books_controller
    end

    it "@book_presenter has a books_controller property (alias for presenting_object in Rails)" do
      @presenter.controller.should == books_controller
    end

  end

  describe "#present with specified presenter type" do

    before do
      books_controller.edit
      @presenter = books_controller.instance_variable_get(:@alt_book_presenter)
    end

    it "assigns @alt_book_presenter (and is the correct type)" do
      @presenter.should_not be_nil
      @presenter.should be_kind_of(AltBookPresenter)
    end

  end

  describe "#present with arguments" do

    before do
      products_controller.show
      @presenter = products_controller.instance_variable_get(:@product_presenter)
    end

    it "passes arguments to the presenter's initialize method" do
      @presenter.arg1.should == "foo"
      @presenter.arg2.should == "bar"
    end

  end

end
