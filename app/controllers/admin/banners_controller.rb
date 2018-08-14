class Admin::BannersController < Admin::AdminController
  before_action :load_banner, except: %i(index create new)
  def index
    @banners = Banner.all.page(params[:page])
                     .per Settings.banner.per_page
  end

  def new
    @banner = Banner.new
  end

  def show; end

  def create
    @banner = Banner.new banner_params
    if params[:product_id]
      @banner.picture = Product.find_by(id: params[:product_id]).avatar
    end
    if @banner.save
      flash[:success] = t(".success")
      redirect_ajax admin_banners_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit; end

  def update
    @banner.assign_attributes banner_params
    if params[:product_id]
      @banner.picture = Product.find_by(id: params[:product_id]).avatar
    end
    if @banner.save
      flash[:success] = t(".success")
      redirect_ajax admin_banners_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def banner_params
    params.require(:banner).permit :title, :link, :picture, :active, :product_id
  end

  def load_banner
    @banner = Banner.find_by id: params[:id]
    return if @banner
    flash[:danger] = t ".not_found"
    redirect_to admin_banners_path
  end
end
