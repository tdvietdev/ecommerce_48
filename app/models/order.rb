class Order < ApplicationRecord
  enum status: {unchecked: 0, checked: 1, done: 2, closed: 3}

  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  delegate :name, :phone, :email, :address, to: :user, prefix: true,
    allow_nil: true

  scope :select_attr, (lambda do
    select :id, :user_id, :status, :shipped_at, :phone, :created_at,
      :grand_total
  end)

  scope :sort_by_status, ->{order :status}
  scope :sort_by_create_at, ->{order :created_at}

  validates :address, presence: true
  validates :phone, presence: true
end
