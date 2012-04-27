# PresentFoo

PresentFoo is meant to be a very lightweight presenter library for
Rails.  Presenters are a great way to move logic out of views and
controllers into a class which represents the state of a "view" whether
that be HTML, JSON, or other.  It's also a way to reduce the junk-drawer
effect that happens in the `/helpers` directory of many large Rails
applications.  This is a super basic implementation and I hope to grow
it over time.  If you have thoughts on things that would be helpful I'd
love the feedback.

## Installation

Add this line to your application's Gemfile:

    gem 'present_foo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install present_foo

## Usage

### Create your Presenters

Presenters are just classes that inherit from Presenter and have a name
which matches the `<Model>Presenter` naming convention (later we'll see
how to override this).

    class Book < ActiveRecord::Base
      def some_model_method
        "foo"
      end
    end

    class BookPresenter < Presenter
      def some_presenter_method
        "bar"
      end
    end

The `Presenter` base class inherits from `SimpleDelegator`, which allows
instances of the presenter to mirror the public interface of
the object they are presenting.  For example, if you have a method on
your presented object or model called `some_model_method`, you can call
it directly on the presenter and it will be delegated to the wrapped
object.

Presenters also all have a hook back to the controller they were created
from.  For example, if you need to get access to helpers or url
generators you can do so from the `controller` method.

    class BookPresenter < Presenter

      # Access to url generators
      def edit_url
        controller.edit_book_url
      end

      # Access to helper methods
      def permalink
        controller.create_permalink(self.title)
      end

    end

You can also access the `request` or any other contextual data that's
available to the controller in this manner.

### Use Presenters in Controllers

In a controller action, you simply call `present` or `present_many` which
sets an instance variable that can be used in views and also returns
an instance of the presenter for use in non-html responses.

    class BooksController < ApplicationController

      def index
        books = Book.all
        present_many books
      end

      def show
        book = Book.find(params[:id])
        present book
      end

    end

    # app/views/books/index.html.haml
    %ul.books
      - @book_presenters.each do |book_presenter|
        %li= book_presenter.title

    # app/views/books/show.html.haml
    %h1= @book_presenter.title
    %h3= @book_presenter.author

### Extending Presenter Initialization

If you need to override the default behavior of a presenter at
construction-time just override the `initialize` or `new_list` methods.

    class BookPresenter < Presenter

      # Maps to present in controllers
      def initialize(obj, arg1, arg2)
        # ... do some more stuff
        super(obj)
      end

      # Maps to present_many in controllers
      def self.new_list(objs, arg1, arg2)
        # ... do some more stuff
        super(objs)
      end

    end

In controllers additional arguments passed to `present` or
`present_many`
will be passed to these overridden constructor methods.

    class BooksController < ApplicationController

      def index
        books = Books.all
        present_many books, "foo", "bar"
      end

    end

### Changing the Default Presenter Type

If you want to name your presenter something other than `<Class>Presenter`
or, if you have more than one presenter for a given type you can simply
pass the class you want to use as the second argument when calling
`present` or `present_many`.

    class BooksController < ApplicationController

      def index
        books = Books.all
        present_many books, OtherBookPresenter, "foo", "bar"
      end

    end

## TODO

1. Do something to assist with serialization scenarios
2. Make PresentFoo work in non-Rails environments

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
