class Permission < ApplicationRecord
  scope :names_asc, ->{select(:subject_class, :id).order(subject_class: :asc)}
end
