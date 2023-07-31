# frozen_string_literal: true

ActiveSupport.on_load(:active_model) do
  ActiveModel::Type.register :address_type, AddressType
end
