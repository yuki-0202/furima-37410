class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  belongs_to :user

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :info
    validates :image
  end

  validates :price,presence: { message: "can't be blank" }
  validates :price,numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }
  validates :price,numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'is out of setting range'}

  
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
end
