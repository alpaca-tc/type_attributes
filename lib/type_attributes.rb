require 'active_support/concern'
require 'active_model'

require 'type_attributes/version'
require 'type_attributes/type'

module TypeAttributes
  extend ActiveSupport::Concern

  module ClassMethods
    def type_attribute(name, cast_type)
      name = name.to_sym
      cast_type = cast_type.to_sym

      define_method name do
        value = instance_variable_get(:"@#{name}")
        TypeAttributes::Type.cast_value(cast_type, value)
      end

      define_method "#{name}=" do |decibels|
        value = TypeAttributes::Type.cast_value(cast_type, decibels)
        instance_variable_set(:"@#{name}", value)
      end
    end
  end
end
