# TypeAttributes

TypeAttributes defines `.type_attribute` method to typecast value with `ActiveModel::Type.lookup(type).cast(value)`.
Supported versions are `ActiveModel(> 5.0)` or `ActiveRecord(> 4.2)`.

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
