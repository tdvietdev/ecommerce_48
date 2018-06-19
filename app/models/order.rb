class Order < ApplicationRecord
  enum status: {unchecked: 0, checked: 1, done: 2}

  belongs_to :user
  has_many :order_details
end
