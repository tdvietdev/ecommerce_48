class Admin::UsersController < Admin::AdminController
  authorize_resource class: false

  before_action :load_user, except: %i(index new create)

  def index
    @users = User.includes(:role)
                 .search(params[:search]).desc_create_at
                 .select_attr
                 .page(params[:page])
                 .per Settings.user.index.per_page
  end

  def new; end

  def create; end

  def show
    respond_to do |format|
      format.js
    end
  end

  def edit
    @roles = Role.except_admin
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t(".success")
      redirect_ajax admin_users_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if !@user.role.super_admin? && @user.destroy
      flash[:success] = t(".success")
    else
      flash[:warning] = t(".error")
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :role_id
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to admin_users_path
  end
end
