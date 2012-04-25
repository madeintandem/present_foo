module PresentFoo::Serialization


  def self.included(base)
    base.extend ClassMethods
    base.send :attr_accessor, :_serializable_attributes
    #base._serializable_attributes = {}    
  end

  module ClassMethods

    def serialize_attributes(*attrs)
      self._serialized_attributes = attrs.uniq!
    end

  end

end
