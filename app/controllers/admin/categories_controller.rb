class Admin::CategoriesController < Admin::AdminController
  before_action :load_category, except: %i(index)

  def index
    @category = Category.new
    @categories = Category.roots
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @category.update_attributes category_params
    respond_to do |format|
      format.js
    end
  end

  def create
    @category = Category.new category_params
    @category.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def category_params
    params.require(:category).permit :id, :name, :code, :parent_code
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".danger"
    redirect admin_categories_path
  end
end
