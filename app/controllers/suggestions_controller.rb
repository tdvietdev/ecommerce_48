class SuggestionsController < ApplicationController
  before_action :load_categories, :logged_in_user

  def new
    @suggestion  = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new suggestion_params
    if @suggestion.save
      flash[:success] = t "Success"
      redirect_to root_path
    else
      flash[:danger] = t "Error"
      render :new
    end
  end

  private
  def suggestion_params
    params.require(:suggestion).permit :user_id, :content
  end
end
