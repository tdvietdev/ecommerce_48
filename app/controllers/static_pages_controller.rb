class StaticPagesController < ApplicationController
  before_action :load_categories, :load_cart, only: %i(home)

  def home; end

  def help; end
end
