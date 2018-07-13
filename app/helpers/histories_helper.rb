module HistoriesHelper
  def load_history user, product
    user.histories.find_by product_id: product.id
  end
end
