class Product < ApplicationRecord
  belongs_to :category
  has_many :images
  has_many :promotions
  has_many :histories
  has_many :order_details
  has_many :rates
end
