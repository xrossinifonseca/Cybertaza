module FilterByDate

  extend ActiveSupport::Concern

   included do
    before_action :set_dates_params, only: [:index]
  end

  private

  def set_dates_params
    return nil if params[:start_date].nil? && params[:end_date].nil?

    @start_date = parse_date_param(params[:start_date])
    @end_date = parse_date_param(params[:end_date]).end_of_day
  end

  # sanatizar
  def filter_by_date(model,column)
    date_fild = model.arel_table[column]
    record = model.where(date_fild.between(@start_date..@end_date))
  end

  def parse_date_param(date_param)
    DateTime.parse(date_param) if date_param.present?
  end

end
