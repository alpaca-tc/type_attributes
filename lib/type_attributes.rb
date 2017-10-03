require 'active_support/concern'

require 'type_attributes/version'
require 'type_attributes/type'

module TypeAttributes
  extend ActiveSupport::Concern

  included do
    @_type_attributes_accessor = Module.new
    include(@_type_attributes_accessor)
  end

  module ClassMethods
    def type_attribute(name, cast_type)
      name = name.to_sym
      cast_type = cast_type.to_sym

      @_type_attributes_accessor.class_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{name}
          TypeAttributes::Type.cast_value(:#{cast_type}, @#{name})
        end

        def #{name}=(decibels)
          @#{name} = TypeAttributes::Type.cast_value(:#{cast_type}, decibels)
        end
      METHOD
    end
  end
end
