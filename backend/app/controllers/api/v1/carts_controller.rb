  class Api::V1::CartsController < Api::V1::BaseController


  def show
    render json: {items: @cart.items,total: @cart.total}
  end



end
