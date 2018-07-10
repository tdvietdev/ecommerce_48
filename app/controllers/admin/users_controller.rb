class Admin::UsersController < Admin::AdminController
  before_action :load_user, except: %i(index new create import)

  def index
    @users = User.search(params[:search]).desc_create_at
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

  def edit; end

  def update; end

  def destroy
    if @user.destroy && !@user.admin?
      flash[:success] = t(".success")
    else
      flash[:warning] = t(".error")
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :avatar, :quantity, :price, :detail
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to admin_users_path
  end
end
