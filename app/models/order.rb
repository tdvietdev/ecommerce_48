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
  scope :sum_money, ->{sum :grand_total}
  scope :search, (lambda do |key|
    where("phone LIKE ? or address LIKE ?", "%#{key}%", "%#{key}%") if key.present?
  end)
  def filter start_date, end_date
    filter_start_date(start_date).filter_end_date(end_date)
  end

  validates :address, presence: true
  validates :phone, presence: true
end
