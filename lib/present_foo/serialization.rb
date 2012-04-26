module PresentFoo::Serialization


  def self.included(base)
    base.extend ClassMethods
    base.send :attr_accessor, :_serializable_attributes
    #base._serializable_attributes = {}    
  end

  module ClassMethods

    def serialize_attributes(*attrs)
      #key = (attrs[0].is_a?(String) || attrs[0].is_a?(Symbol)) ? attrs[0] : :default
      #self._serialized_attributes = attrs.uniq!
    end

  end

end
