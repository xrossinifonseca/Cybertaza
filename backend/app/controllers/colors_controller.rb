class ColorsController < ApplicationController

  def index
    @colors = Color.all
    render json: {colors:@colors }
   end

  def new
    @color = Color.new
  end



end
