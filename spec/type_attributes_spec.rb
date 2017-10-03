require 'spec_helper'

describe TypeAttributes do
  it 'has a version number' do
    expect(TypeAttributes::VERSION).not_to be nil
  end

  let(:types) do
    if described_class::Type::IS_RAILS_5
      rails5_0_types
    else
      rails4_2_types
    end
  end

  let(:rails4_2_types) do
    {
      big_integer: ['1', 1],
      binary: ['1', '1'],
      boolean: ['1', true],
      date: ['2016-01-01', Date.parse('2016-01-01')],
      date_time: ['2016-01-01', DateTime.parse('2016-01-01')],
      decimal: ['1', 1],
      float: ['1', 1.0],
      integer: ['1', 1],
      string: ['1', '1'],
      text: ['1', '1'],
      time: ['2000/01/01 00:00:00', Time.parse('2000-01-01 00:00:00 UTC')],
    }
  end

  let(:rails5_0_types) do
    {
      big_integer: ['1', 1],
      binary: ['1', '1'],
      boolean: ['1', true],
      date: ['2016-01-01', Date.parse('2016-01-01')],
      date_time: ['2016-01-01', DateTime.parse('2016-01-01')],
      decimal: ['1', 1],
      float: ['1', 1.0],
      integer: ['1', 1],
      string: ['1', '1'],
      time: ['2000/01/01 00:00:00', Time.parse('2000-01-01 00:00:00 UTC')],
    }
  end

  let(:klass) do
    Class.new.tap do |klass_value|
      klass_value.class_exec(types) do |type_with_value|
        include(TypeAttributes)

        type_with_value.keys.each do |type|
          type_attribute(type, type)
        end
      end
    end
  end

  let(:instance) { klass.new }

  it 'cast value to type' do
    types.each do |key, (from, to)|
      expect(instance.public_send(key)).to be_nil
      instance.public_send("#{key}=", from)
      expect(instance.public_send(key)).to eq(to)
    end
  end
end
