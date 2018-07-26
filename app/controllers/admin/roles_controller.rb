class Admin::RolesController < Admin::AdminController
  authorize_resource class: false

  before_action :load_role, except: %i(index new create)

  def index
    @roles = Role.page(params[:page])
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
    @role = Role.new
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def create
    @role = Role.new role_params
    if @role.save
      flash[:success] = t(".success")
      redirect_ajax admin_roles_path
    else
      respond_to{|format| format.js}
    end
  end

  def update
    if @role.update_attributes role_params
      flash[:success] = t(".success")
      redirect_ajax admin_roles_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @role.destroy
        format.html do
          flash[:success] = t(".success")
          redirect_to admin_roles_path
        end
      else
        format.html do
          flash[:error] = t(".error")
          redirect_to admin_roles_path
        end
      end
    end
  end

  private
  def load_role
    @role = Role.find_by id: params[:id]
    return if @role
    flash[:danger] = t ".danger"
    redirect_to admin_roles_path
  end

  def role_params
    params.require(:role).permit :name, :description, :permission_ids => []
  end
end
