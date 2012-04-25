class Presenter < SimpleDelegator

  include PresentFoo::Serialization

  def initialize(obj)
    super(obj)
  end

  attr_accessor :presenting_object
  alias_method :controller, :presenting_object if defined?(::Rails)

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
