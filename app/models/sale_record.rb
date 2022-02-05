class SaleRecord < ApplicationRecord
  attr_accessor :token

  belongs_to :user
  belongs_to :item
  has_one :destination
end
