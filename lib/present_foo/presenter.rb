class Presenter < SimpleDelegator

  def initialize(obj)
    super(obj)
  end

  attr_accessor :host
  alias_method :controller, :host if defined?(::Rails)

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
