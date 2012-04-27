class Presenter < SimpleDelegator

  def initialize(obj, *args)
    super(obj)
  end

  attr_accessor :presenting_object
  alias_method :controller, :presenting_object if defined?(::Rails)

  def self.new_list(objs, *args)
    objs.map { |o| new(o) }
  end

  def obj
    __getobj__
  end

  def class
    obj.class
  end

end
