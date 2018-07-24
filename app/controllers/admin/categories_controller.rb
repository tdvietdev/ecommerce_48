class Admin::CategoriesController < Admin::AdminController
  authorize_resource class: false

  before_action :load_category, except: %i(index create)

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
    Category.skip_callbacks = true
    @category.update_attributes category_params
    Category.skip_callbacks = false
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

  def select_branch
    @list_branch = Category.get_sellect @category
  end

  def update_branch
    @category.move_branch params[:option]
    flash[:success] = t(".success")
    redirect_ajax admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :id, :name, :code, :parent_code
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".danger"
    redirect_to admin_categories_path
  end
end
