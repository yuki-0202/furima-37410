class SaleRecordDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :address, :building, :phone_number, :sale_record_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :phone_number, presence: true
  validates :phone_number, format: { with: /\A.{10,11}\z/, message: 'is too short' }
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: ' is invalid. Input only number' }

  def save
    sale_record = SaleRecord.create(user_id: user_id, item_id: item_id)
    Destination.create(
      postal_code: postal_code, prefecture_id: prefecture_id,
      city: city, address: address, building: building,
      phone_number: phone_number, sale_record_id: sale_record.id
    )
  end
end
