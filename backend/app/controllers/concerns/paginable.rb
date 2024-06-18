module Paginable

  extend ActiveSupport::Concern

  included do
    before_action :set_pagination_params, only: [:index]
  end

  private
  def set_pagination_params
    @page = (params[:page] || 1).to_i
    @per_page = (params[:per_page] || 5).to_i


    @per_page = 1 if @per_page == 0
  end

  def paginate(collection)
    collection.page(@page).per(@per_page)
  end


  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

end
