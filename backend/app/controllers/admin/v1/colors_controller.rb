  class Api::V1::ColorsController < Api::V1::BaseController


  def index
    @colors = Color.all
    render json: {colors:@colors }
   end

  def new
    @color = Color.new
  end



end
