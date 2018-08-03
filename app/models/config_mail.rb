class ConfigMail
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :address, :user_name, :password, :port, :domain

  ATTRIBUTES = ["address", "user_name", "password", "port", "domain"]

  def initialize attributes = {}
    attributes.each do |attribute, value|
      send("#{attribute}=", value)
    end
  end

  def persisted?
    false
  end

  class << self
    ATTRIBUTES.each do |attribute|
      define_method attribute do
        Marshal.load(File.binread("config_mail")).send attribute
      end
    end
  end
end
