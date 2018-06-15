class Category < ApplicationRecord
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :children, class_name: Category.name, foreign_key: :parent_id,
    dependent: :destroy
end
