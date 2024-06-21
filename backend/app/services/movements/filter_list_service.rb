
module Movements


class FilterListService




  def self.by_type(movement)

    type = movement.downcase

    if type == "exit" || type == "entrance"
      type_movement = Movement.arel_table[:type_movement]
      movements = Movement.where(type_movement.eq(type))
    else
      movements = Movement.all
    end
  end
end
end
