class Admin::ConfigMailsController < Admin::AdminController
  before_action :load_config, only: :index

  def create
    @config_mail = ConfigMail.new config_params
    File.open("config_mail", "wb"){|f| f.write(Marshal.dump @config_mail)}
    flash[:success] = t ".success"
    redirect_to admin_config_mails_path
  end

  private
  def config_params
    params.require(:config_mail).permit :address, :user_name, :password, :port,
      :domain
  end

  def load_config
    @config_mail = Marshal.load File.binread("config_mail")
  end
end
