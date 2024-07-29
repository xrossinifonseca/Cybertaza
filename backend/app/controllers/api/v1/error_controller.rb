  class Api::V1::ErrorController < Api::V1::BaseController

  def not_found
    render json: { error: 'Rota não encontrada' }, status: :not_found
  end
end
