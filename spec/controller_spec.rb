require "spec_helper"

describe BooksController do

  let(:controller) { BooksController.new }

  it "should have a present method" do
    controller.respond_to?(:present).should be_true
  end

  it "should have a present_many method" do
    controller.respond_to?(:present_many).should be_true
  end

  describe "/index" do

    before do
      controller.index
      @presenters = controller.instance_variable_get(:@book_presenters)
    end

    it "assigns @book_presenters" do
      @presenters.should_not be_nil
      @presenters.should be_kind_of(Array)
    end

  end

  describe "/show" do

    before do
      controller.show
      @presenter = controller.instance_variable_get(:@book_presenter)
    end

    it "assigns @book_presenter" do
      @presenter.should_not be_nil
      @presenter.should be_kind_of(BookPresenter)
    end

    it "@book_presenter has a presenting_object property" do
      @presenter.presenting_object.should == controller
    end

    it "@book_presenter has a controller property (alias for presenting_object in Rails)" do
      @presenter.controller.should == controller
    end

  end

  describe "/edit" do

    before do
      controller.edit
      @presenter = controller.instance_variable_get(:@alt_book_presenter)
    end

    it "assigns @alt_book_presenter (and is the correct type)" do
      @presenter.should_not be_nil
      @presenter.should be_kind_of(AltBookPresenter)
    end

  end

end
