class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  delegate :id, :name, :price, to: :product, prefix: true,
           allow_nil: true
  delegate :id, :status, to: :order, prefix: true,
           allow_nil: true
  scope :by_order, ->(order_id){where(order_id: order_id)}
end
