class SearchParseItems

  def self.call(initial_scope, params)
    initial_scope = initial_scope.search(params[:title]) if params[:title].present?
    initial_scope = initial_scope.where(chosen: params[:chosen]) if params[:chosen].present?
    initial_scope = initial_scope.where(status: params[:status]) if params[:status].present?
    
    if params[:created_at].present?
      date = Date.strptime(params[:created_at], "%d.%m.%y")
      initial_scope = initial_scope.where(created_at: date.beginning_of_day..date.end_of_day)
    end
    initial_scope
  end
end