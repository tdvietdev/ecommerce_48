class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  acts_as_url :name, url_attribute: :slug, sync_url: true

  before_validation :set_default_role

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
    format: {with: VALID_PHONE_REGEX}, allow_nil: true
  validates :address, presence: true,
    length: {maximum: Settings.user.address.max_length}, allow_nil: true
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

  class << self
    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[Settings.user.token_min, Settings.user.token_max]
        user.name = auth.info.name
        user.role_id = 1
      end
    end

    def super_admin
      where(role_id: 2).first
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def set_default_role
    self.role_id ||= 1
  end
end
