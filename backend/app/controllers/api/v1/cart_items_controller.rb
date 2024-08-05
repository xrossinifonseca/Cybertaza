  class Api::V1::CartItemsController < Api::V1::BaseController



  before_action :set_cart_item, only: [:destroy, :add]

  def create

    quantity = item_params[:quantity].to_i

    begin

    if is_product_already_added
      item = CartItem.find_by(cart_id: @cart.id , product_id: item_params[:product_id])
      item.update!(quantity: quantity + item.quantity)
      render json: {message:"quantity product updated",item: item}

    else

    item = CartItem.create!(item_params.merge(cart: @cart))

    render json: {message:"product added to cart",item:item}

  end

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    end
  end




  def add
    begin
      @cart_item.quantity += 1
      @cart_item.save!


      render json: {message:"increased quantity"}

    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end


  def destroy
    begin
    @cart_item.destroy!
    render json: {message:"Item removed"}

    rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    end

  end





  private

  def item_params
   params.permit(:product_id,:quantity)
  end

  def set_cart_item
    begin
      @cart_item = CartItem.find(params[:id])

    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  def is_product_already_added
    CartItem.exists?(cart_id: @cart.id, product_id: item_params[:product_id])
  end


end
