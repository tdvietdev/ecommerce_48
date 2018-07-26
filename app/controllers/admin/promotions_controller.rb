class Admin::PromotionsController < Admin::AdminController
  authorize_resource class: false

  before_action :load_promotion, except: %i(index new create)
  before_action :load_product

  def index
    @promotions = @product.promotions.desc_end_date
                          .page(params[:page])
                          .per Settings.promotion.per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @promotion = @product.promotions.build
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def create
    @promotion = Promotion.new promotion_params
    if @promotion.save
      flash[:success] = t(".success")
      redirect_ajax admin_product_promotions_path
    else
      respond_to{|format| format.js}
    end
  end

  def update
    if @promotion.update_attributes promotion_params
      flash[:success] = t(".success")
      redirect_ajax admin_product_promotions_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @promotion.destroy
        format.html do
          redirect_to admin_product_promotions_path, notice: t(".success")
        end
      else
        format.html do
          redirect_to admin_product_promotions_path, notice: t(".error")
        end
      end
    end
  end

  private
  def load_promotion
    @promotion = Promotion.find_by id: params[:id]
    return if @promotion
    flash[:danger] = t ".danger"
    redirect_to admin_products_path
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t ".danger"
    redirect_to admin_products_path
  end

  def promotion_params
    params.require(:promotion).permit :percent, :start_date, :end_date,
      :product_id
  end
end
