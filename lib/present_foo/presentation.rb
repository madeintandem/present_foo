module Presentation

  extend ActiveSupport::Concern

  included do

    define_method :present do |obj, *args|
      klass = presenter_klass(obj, args[0])
      presenter = create_presenter(klass, obj, self, *args)
      set_instance_variable(klass, self, presenter, obj)
      presenter
    end

    define_method :present_many do |objs, *args|
      klass = presenter_klass(objs.first, args[0])
      presenters = create_many_presenters(klass, objs, self, *args)
      set_instance_variable(klass, self, presenters, objs, true)
      presenters
    end

  end

  private

  def create_presenter(klass, obj, host, *args)
    arity = klass.method(:initialize).arity
    presenter = (arity > 1) ? klass.new(obj, *args) : klass.new(obj)
    presenter.host = host
    presenter
  end

  def create_many_presenters(klass, objs, host, *args)
    objs.map { |o| create_presenter(klass, o, host, *args) }
  end

  def set_instance_variable(klass, host, value, obj, pluralize = false)
    var_name = "@#{klass.to_s.underscore}#{"s" if pluralize}".to_sym
    host.instance_variable_set(var_name, value)
  end

  def presenter_klass(obj, arg0)
    return arg0 if arg0.kind_of?(Class)
    klass_name = "#{obj.class}Presenter"
    begin
      return klass_name.constantize
    rescue NameError
      raise PresentFoo::Errors::PresenterNotFound.new("Could not find a presenter for #{obj.class}, looked for #{class_name}.")
    end
  end

end
