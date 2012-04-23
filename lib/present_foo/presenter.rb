class Presenter < SimpleDelegator

  #include Rails.application.routes.url_helpers

  #def default_url_options
    #ActionMailer::Base.default_url_options if defined?(ActionMailer)
  #end

  def initialize(obj)
    super(obj)
  end

  attr_accessor :request

  def self.new_list(objs)
    objs.map { |o| new(o) }
  end

  def obj
    __getobj__
  end

  def class
    obj.class
  end

end
