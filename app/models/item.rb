class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :info
  end

  validates :price,
    presence: { message: "Price can't be blank" },
    numericality: {
      only_integer: true,message: 'Price is invalid. Input half-width characters',
      greater_than_or_equal_to: 300, message: 'Price is out of setting range',
      less_than_or_equal_to: 9999999, message: 'Price is out of setting range'
    }
  
  validates :category_id, numericality: { other_than: 1, message: "Category can't be blank" }
  validates :status_id, numericality: { other_than: 1, message: "Sales status can't be blank"}
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "Shipping fee status can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1, message: "Prefecture can't be blank"}
  validates :scheduled_delivery_id, numericality: { other_than: 1, message: "Scheduled delivery can't be blank"}
end
