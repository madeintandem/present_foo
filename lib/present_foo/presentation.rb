module Presentation

  extend ActiveSupport::Concern

  included do

    define_method :present do |obj|
      presenter = presenter_class_name(obj).new(obj)
      presenter.request = self.request if self.respond_to?(:request)
      var_name = instance_variable_name(obj)
      self.instance_variable_set(var_name, presenter)
    end

    define_method :present_many do |objs|
      presenter = presenter_class_name(objs.first).new_list(objs)
      var_name = instance_variable_name(objs.first, true)
      self.instance_variable_set(var_name, presenter)
    end

  end

  private

  def instance_variable_name(obj, pluralize = false)
    "@#{obj.class.to_s.underscore}_presenter#{"s" if pluralize}".to_sym
  end

  def presenter_class_name(obj)
    "#{obj.class}Presenter".constantize
  end

end
