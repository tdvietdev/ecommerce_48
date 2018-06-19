class Product < ApplicationRecord
  belongs_to :category
  has_many :images, dependent: :delete_all
  has_many :promotions
  has_many :histories
  has_many :order_details
  has_many :rates
  before_destroy :check_exits_order

  validates :name, length: {
    maximum: Settings.product.max_name, minimum: Settings.product.min_name
  }
  validates :quantity, :price, numericality: true
  validates :category_id, presence: true

  scope :desc_create_at, ->{order(created_at: :desc)}
  scope :search, ->(key){where("name LIKE ? ", "%#{key}%") if key.present?}
  scope :select_attr, ->{select :id, :name, :quantity, :price, :category_id}
  class << self
    def import file
      spreadsheet = open_spreadsheet file
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_by_id(row["id"]) || new
        product.attributes = row.to_hash.slice(*row.to_hash.keys)
        product.save!
      end
    end

    def open_spreadsheet file
      case File.extname file.original_filename
      when ".csv" then Roo::CSV.new file.path
      when ".xls" then Roo::Excel.new file.path
      when ".xlsx" then Roo::Excelx.new file.path
      else raise file.original_filename
      end
    end
  end

  private
  def check_exits_order
    return if order_details.empty?
    errors[:base] << t(".exits_order")
    throw :abort
  end
end
