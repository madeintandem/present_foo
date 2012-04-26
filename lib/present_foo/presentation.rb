module Presentation

  extend ActiveSupport::Concern

  included do

    define_method :present do |obj, *args|
      klass = presenter_klass(obj, args)
      presenter = create_presenter(klass, obj, self, args)
      set_instance_variable(klass, self, presenter, obj)
      presenter
    end

    define_method :present_many do |objs, *args|
      klass = presenter_klass(objs.first, args)
      presenters = create_many_presenters(klass, objs, self, args)
      set_instance_variable(klass, self, presenters, objs, true)
      presenters
    end

  end

  private

  def create_presenter(klass, obj, source, args)
    presenter = klass.new(obj, *args)
    presenter.presenting_object = source
    presenter
  end

  def create_many_presenters(klass, objs, source, args)
    objs.map { |o| create_presenter(klass, o, source, args) }
  end

  def set_instance_variable(klass, source, value, obj, pluralize = false)
    var_name = "@#{klass.to_s.underscore}#{"s" if pluralize}".to_sym
    source.instance_variable_set(var_name, value)
  end

  def presenter_klass(obj, args)
    return args.shift if args[0].kind_of?(Class)
    klass_name = "#{obj.class}Presenter"
    begin
      return klass_name.constantize
    rescue NameError
      raise PresentFoo::Errors::PresenterNotFound.new("Could not find a presenter for #{obj.class}, looked for #{class_name}.")
    end
  end

end
