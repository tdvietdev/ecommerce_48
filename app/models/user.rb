class User < ApplicationRecord
  enum permission: {admin: 1, staff: 2, customer: 3}

  has_many :rates
  has_many :orders
  has_many :suggestions
  has_many :histories
end
