class Promotion < ApplicationRecord
  belongs_to :product

  validates :percent, numericality: {greater_than: 0, less_than: 100}

  scope :desc_end_date, ->{order(end_date: :desc)}
  scope :desc_percent, ->{order(percent: :desc)}
  scope :last_date, ->{order(end_date: :desc).first}
  scope :sellect_attr, ->{select :percent, :end_date, :start_date}
  scope :between, (lambda do |date|
    where "end_date >= ? AND start_date <= ?", date, date
  end)
end
