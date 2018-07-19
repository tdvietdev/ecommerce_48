class History < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :lasted_visit, ->{order updated_at: :desc}
end
