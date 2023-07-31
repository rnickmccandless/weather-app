# frozen_string_literal: true

class AddressType < ActiveModel::Type::Value
  def cast(value)
    return if value.blank?

    if value.is_a?(Address)
      value
    elsif value.is_a?(Hash)
      Address.new(value.symbolize_keys)
    else
      raise ArgumentError, "Invalid address value: #{value.inspect}"
    end
  end

  def serialize(value)
    return nil if value.blank?

    value.to_s
  end

  def deserialize(value)
    value
  end

  def ==(other)
    other.is_a?(AddressType)
  end
end
