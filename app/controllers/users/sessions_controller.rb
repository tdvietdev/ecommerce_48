class Users::SessionsController < Devise::SessionsController
  before_action :load_categories

  def new; end

   def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    redirect_ajax after_sign_in_path_for(resource)
  end
end
