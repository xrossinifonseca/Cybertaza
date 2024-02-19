class ErrorController < ApplicationController
  def not_found
    render json: { error: 'Rota não encontrada' }, status: :not_found
  end
end
