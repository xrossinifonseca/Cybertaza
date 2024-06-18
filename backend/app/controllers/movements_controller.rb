class MovementsController < ApplicationController

   before_action :check_permission, only: [:create]
   include Paginable
   include FilterByDate


# resolver bug estoque negativo
  def index
    movements = Movement.all
    start_date = filter_params[:start_date]
    end_date = filter_params[:end_date]
    type_movement = filter_params[:type_movement]

    if type_movement.present?
      movements = Movements::FilterListService.by_type(type_movement)
    end

    if start_date.present? && end_date.present?
      movements =  filter_by_date(movements,:date_movement)
    end


    paginated_movements = paginate(movements)
    render json: {movements: paginated_movements, meta: pagination_meta(paginated_movements)}

  end


  def create
    begin
    movement = Movement.create!(movement_params)
    render json: {message:"movement successfully created", movement:movement}, status: :created

    rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
    rescue e
      render json: { error: "There was an internal server error" }, status: :internal_server_error
    end
  end


  private

  def movement_params
    params.require(:movement).permit(:quantity,:product_id,:type_movement,:date_movement)
  end

  def filter_params
    params.permit(:start_date, :end_date,:type_movement)
  end



  def check_permission
    unless (PermissionsAdmin::PERMISSIONS[@current_user.role] & ["create", "update", "delete"]).any?
      return render json: { message: "unauthorized" }, status: :unauthorized
    end

  end

end
