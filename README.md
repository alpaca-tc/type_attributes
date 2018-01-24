# TypeAttributes

**Deprecation warning**

This gem no longer maintained.

In Rails5.2, Rails support `.attribute` method with `ActiveModel::Attributes`.
Please remove this gem and replace `type_attribute(:name, :type)` with `attribute(:name, :type)`.

In under Rails 5.2, please use [ActiveModelAttributes backport](https://github.com/alpaca-tc/active_model_attributes_backport) instead of.

---

TypeAttributes defines `.type_attribute` method to cast value with `ActiveModel::Type`.
Supported versions are Rails `4.2`, `5.0` and `5.1`.

```
class User
  include TypeAttributes

  type_attribute :id, :integer
end

user = User.new
user.id = '1'
user.id == 1 #=> true
```

```
# Lookup type from `ActiveModel::Type.lookup(type)` 
# ActiveModel::Type.registry.send(:registrations).map { |type| type.send(:name) }
:big_integer
:binary
:boolean
:date
:datetime
:decimal
:float
:integer
:string
:text
:time
```

## Deprecation Warning

Typed attribute is already supported in Rails5.2
https://github.com/rails/rails/pull/30985

You shouldn't use this gem, and replace it as following.

```ruby
# before
type_attribute :key, :integer

# after
attribute :key, :integer
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'type_attributes'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alpaca-tc/type_attributes.
