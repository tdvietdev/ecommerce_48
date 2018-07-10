class Suggestion < ApplicationRecord
  enum status: {unchecked: 0, checked: 1, replied: 2, cancled: 3}

  belongs_to :user

  delegate :name, :phone, :email, :address, to: :user, prefix: true,
           allow_nil: true

  scope :select_attr, (lambda do
    select :id, :user_id, :status, :content, :created_at
  end)

  scope :sort_by_status, ->{order :status}
  scope :sort_by_create_at, ->{order :created_at}
end
