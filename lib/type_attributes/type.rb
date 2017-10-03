require 'active_model'

module TypeAttributes
  module Type
    IS_RAILS_5 = defined?(ActiveModel) && ActiveModel.gem_version >= Gem::Version.new('5.0.0')

    # Change type name for DateTime in Rails5
    # related: https://github.com/rails/rails/pull/24079
    DATETIME_TYPE = IS_RAILS_5 ? :datetime : :date_time

    def self.flexible_type_name(type)
      if %i(date_time datetime).include?(type)
        DATETIME_TYPE
      else
        type
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
end
