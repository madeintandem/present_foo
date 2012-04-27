# TODO: Still thinking about this.
#module PresentFoo::Serialization

  #def self.included(base)
    #base.extend ClassMethods
    #base.send :class_variable_set, :@@_serializable_attributes, []
  #end

  #module ClassMethods

    #def serialize_attributes(*attrs)
      #self._serializable_attributes += attrs
      #self._serializable_attributes.uniq!
    #end

  #end

#end
