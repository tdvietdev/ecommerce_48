class Admin::ProductsController < Admin::AdminController
  before_action :load_product, except: %i(index new create import)

  def index
    @products = Product.includes(:category)
                       .search(params[:search]).desc_create_at.select_attr
                       .page(params[:page])
                       .per Settings.product.per_page
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t(".success")
      redirect_to admin_products_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = t(".success")
      redirect_to admin_products_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.html{redirect_to admin_products_url, notice: t(".success")}
      else
        format.html{redirect_to admin_products_url, notice: t(".error")}
      end
    end
  end

  def import
    if !params[:file].present?
      flash[:danger] = t(".not_found")
    else
      Product.import params[:file]
      flash[:success] = t(".success")
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit :name, :avatar, :quantity, :price, :detail,
      :category_id
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    redirect_to admin_products_path
  end
end
