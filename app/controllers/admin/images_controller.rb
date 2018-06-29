class Admin::ImagesController < Admin::AdminController
  before_action :load_image, only: %i(:show edit update destroy)

  def index; end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new image_params
    @image.product_id = params[:product_id]
    @image.image = params[:file]
    respond_to do |format|
      if @image.save
        format.json{render json: @image}
      else
        format.json{render json: @image.errors, status: :unprocessable_entity}
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @image.update image_params
        format.json{render :show, status: :ok, location: @image}
      else
        format.json{render json: @image.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    old_image = @image
    @image.destroy
    respond_to do |format|
      if @image.destroy
        format.json{render json: old_image}
      else
        format.json{render json: @image.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def image_params
    params.require(:image).permit :product_id, :image
  end

  def load_image
    @image = Image.find_by id: params[:id]
    return if @image
    redirect_to admin_products_path
  end
end
