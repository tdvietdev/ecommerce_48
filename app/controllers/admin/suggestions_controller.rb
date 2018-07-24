class Admin::SuggestionsController < Admin::AdminController
  authorize_resource class: false

  before_action :load_suggestion, only: %i(edit update show)

  def index
    @suggestions = Suggestion.select_attr.includes(:user)
                             .page(params[:page])
                             .sort_by_status.sort_by_create_at
                             .per Settings.suggestion.per_page
  end

  def show; end

  def edit; end

  def update
    if @suggestion.update suggestion_params
      flash[:success] = t ".success"
      redirect_to admin_suggestions_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit :status
  end

  def load_suggestion
    @suggestion = Suggestion.includes(:user).find_by id: params[:id]
    return if @suggestion
    flash[:danger] = t ".not_found"
    redirect_to admin_suggestions_path
  end
end
