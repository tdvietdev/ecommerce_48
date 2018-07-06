class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  scope :by_order, ->(order_id){where(order_id: order_id)}
end
