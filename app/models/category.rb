class Category < ApplicationRecord
  cattr_accessor :skip_callbacks

  acts_as_url :name, url_attribute: :slug, sync_url: true

  belongs_to :parent, class_name: Category.name, optional: true,
    foreign_key: :parent_code, primary_key: :code
  has_many :products

  before_save :set_code, :unless => :skip_callbacks
  before_destroy :check_have_children, :check_have_product
  validates :name, length: {
    minimum: Settings.category.name_min,
    maximum: Settings.category.name_max
  }

  scope :roots, ->{where(parent_code: "0")}

  def root?
    parent_code == "0"
  end

  def parent?
    !children.empty?
  end

  def children slv = 1
    lv_self = code.split("_").size
    childrent = Category.where "code LIKE ?", "#{code}_%"
    childrent.select do |child|
      child.code.split("_").size - lv_self <= slv
    end
  end

  def get_path m_category = self
    m_path = "/" + m_category.name
    loop do
      break if m_category.children.nil? || m_category.parent.nil?
      m_path.prepend("/" + m_category.parent.name)
      m_category = m_category.parent
    end
    m_path
  end

  def move_branch new_id = nil
    @des_branch = Category.find_by id: new_id
    #get add child
    old_code = code
    old_childs = get_all_child
    if new_id.empty?
      self.parent_code = "0"
    else
      self.parent_code = @des_branch.code
    end
    self.code = get_code_value
    Category.transaction do
      self.save
      old_childs.each do |child|
        child.code = child.update_parent_code old_code, code
        child.save
      end
    end
  end

  def get_all_child
    Category.where("code LIKE ? AND id <> ?", "#{code}%", id)
  end

  class << self
    def get_list_path
      arr = all
      arr.map do |cate|
        {id: cate.id, path: cate.get_path} if cate.children.empty?
      end.compact
    end

    def get_sellect category
      arr = where("code NOT LIKE ?", "#{category.code}%")
      arr.map do |cate|
        [cate.get_path, cate.id]
      end.compact
    end
  end

  def cate_parent_tree
    temp_cat = self
    array_category = Array.new
    loop do
      break if temp_cat.parent.nil?
      array_category.unshift(temp_cat.parent)
      temp_cat = temp_cat.parent
    end
    array_category
  end

  def get_all_product
    categories_id = Category.where("code LIKE ?", "#{code}%")
                            .map(&:id)
    Product.where(category_id: categories_id)
  end

  def get_max_price
    products.maximum(:price)
  end

  def get_code_value
    m_arr = Category.select(:code).where(parent_code: parent_code).to_a
    m_arr.map!{|cate| cate.code.split("_").last.to_i}
    i_code = get_min_value m_arr.sort!
    return i_code.to_s.rjust(2, "0") if parent_code == "0"
    parent_code + "_" + i_code.to_s.rjust(2, "0")
  end

  def update_parent_code old_code, new_code
    self.code = code.sub old_code, new_code
    self.parent_code = parent_code.sub old_code, new_code
  end

  def to_param
    "#{id}-#{slug}"
  end

  private


  def set_code
    self.parent_code = "0" if parent_code.nil?
    self.code = get_code_value
  end

  def check_have_children
    return if children.empty?
    errors[:base] << I18n.t("category.has_children")
    throw :abort
  end

  def check_have_product
    return if products.empty?
    errors[:base] << I18n.t("category.has_product")
    throw :abort
  end

  def get_min_value m_arr
    i = 0
    loop do
      break if m_arr[i] != i || m_arr[i].nil?
      i += 1
    end
    i
  end
end
