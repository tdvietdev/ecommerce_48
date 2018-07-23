class Role < ApplicationRecord
  has_many :users
  before_save :check_exist
  before_destroy :check_exits_user, :check_base_role

  validates :name, length: {minimum: 3}

  scope :except_admin, ->{where.not(name: "Super Admin")}

  def super_admin?
    name == "Super Admin"
  end

  def base_role?
    ["Super Admin", "User"].include? name
  end
  private
  def check_exist
    return if exist? name
    errors[:base] << I18n.t("role.exist")
    throw :abort
  end

  def check_base_role
    return unless base_role?
    errors[:base] << I18n.t("role.base")
    throw :abort
  end

  def exist? name
    Role.where(name: name).empty?
  end

  def check_exits_user
    return if users.empty?
    errors[:base] << I18n.t("role.exits_user")
    throw :abort
  end
end
