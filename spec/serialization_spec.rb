require "spec_helper"

describe "PresentFoo::Serialization" do

  let(:book) { Book.new(title: "Jack and Jill", author: "Old Guy", isbn: 12345, publish_date: (DateTime.now - 60)) }
  let(:presenter) { BookPresenter.new(book) }

  it "allows you to whitelist a set of attributes for serialization" do

  end

  it "allows you to group the set of serializable attributes by a key"

  it "#as_json returns a hash of the given serializable attributes"

end
