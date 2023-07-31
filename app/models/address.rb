class Address
  include ActiveModel::API
  include ActiveModel::Attributes

  attribute :street
  attribute :city
  attribute :state
  attribute :zipcode
  attribute :country

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :country, presence: true

  def to_s
    "#{street}, #{city}, #{state}, #{zipcode}, #{country}"
  end
end
