require "spec_helper"

describe Presenter do

  let(:book) { Book.new }
  let(:presenter) { BookPresenter.new(book) }
  let(:books) { [Book.new, Book.new, Book.new] }

  it ".obj returns the original object" do
    presenter.obj.object_id.should == book.object_id
  end

  it ".class returns the class of the original object" do
    presenter.class.should == Book
  end

  it "#new_list maps the given array to a list of presenters" do
    presenters = BookPresenter.new_list(books)
    presenters.size.should == 3
    presenters[0].obj.object_id.should == books[0].object_id
    presenters[1].obj.object_id.should == books[1].object_id
    presenters[2].obj.object_id.should == books[2].object_id
  end

end
