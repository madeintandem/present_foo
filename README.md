# PresentFoo

PresentFoo is meant to be a very lightweight presenter library for
Rails.

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
which matches the <Model>Presenter naming convention (later we'll see
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

The Presenter base class inherits from SimpleDelegator, which makes
instances of the presenter mirror the public methods and attributes of
the object they are presenting.

### Use Presenters in Controllers

In a controller action, you simply call present or present_many which
sets an instance variable that can be used in views and also returns
an instance of the presenter for use in non-view responses.

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
