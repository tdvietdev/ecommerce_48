class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  acts_as_url :name, url_attribute: :slug, sync_url: true

  has_many :rates
  has_many :orders
  has_many :suggestions
  has_many :histories
  belongs_to :role

  delegate :id, :name, to: :role, prefix: true

  validates :name, presence: true,
    length: {maximum: Settings.user.name.max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email.max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  VALID_PHONE_REGEX = /\A[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$\z/
  validates :phone, presence: true,
    format: {with: VALID_PHONE_REGEX}
  validates :address,
    length: {maximum: Settings.user.address.max_length}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.min_length}, allow_nil: true

  scope :desc_create_at, ->{order(created_at: :desc)}
  scope :select_attr, ->{select :id, :name, :phone, :email, :role_id}
  scope :search, (lambda do |key|
    where("name LIKE ? or phone LIKE ?", "%#{key}%", "%#{key}%") if key.present?
  end)

  def visited_product? product
    return histories.find_by(product_id: product.id).nil? ? false : true
  end

  def visited_product product
    return histories.create product_id: product.id
  end

  def to_param
    "#{id}-#{slug}"
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
