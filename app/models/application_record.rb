class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :filter_end_date, (lambda do |date|
    where("created_at <= ?", date) if date.present?
  end)
  scope :filter_start_date, (lambda do |date|
    where("created_at >= ?", date) if date.present?
  end)

  scope :filter, (lambda do |start_date, end_date|
    filter_start_date(start_date).filter_end_date(end_date)
  end)
end
