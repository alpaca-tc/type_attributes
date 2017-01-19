require 'type_attributes/version'
require 'active_support/concern'
require 'active_model'

module TypeAttributes
  extend ActiveSupport::Concern

  IS_RAILS_5 = defined?(ActiveModel) && ActiveModel.gem_version >= Gem::Version.new('5.0.0')

  module ClassMethods
    def type_attribute(name, cast_type)
      name = name.to_sym
      cast_type = cast_type.to_sym

      define_method name do
        value = instance_variable_get(:"@#{name}")
        TypeAttributes.cast_value(cast_type, value)
      end

      define_method "#{name}=" do |decibels|
        value = TypeAttributes.cast_value(cast_type, decibels)
        instance_variable_set(:"@#{name}", value)
      end
    end
  end

  def self.flexible_type_name(type)
    return type unless %i(date_time datetime).include?(type)

    if IS_RAILS_5
      # Change type name for DateTime in Rails5
      # related: https://github.com/rails/rails/pull/24079
      :datetime
    else
      :date_time
    end
  end

  if IS_RAILS_5
    # Rails 5
    require 'active_model/type'

    def self.cast_value(cast_type, value)
      ActiveModel::Type.lookup(flexible_type_name(cast_type)).cast(value)
    end
  else
    # Rails 4.2
    require 'active_record'
    require 'active_support/core_ext/hash/keys'
    require 'active_record/type'

    def self.cast_value(cast_type, value)
      classified = ActiveSupport::Inflector.classify(flexible_type_name(cast_type).to_s)
      type = ActiveRecord::Type.const_get(classified)
      type.new.type_cast_from_user(value)
    end
  end
end
