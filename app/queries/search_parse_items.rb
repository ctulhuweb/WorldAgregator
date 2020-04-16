class SearchParseItems

  def self.call(initial_scope, params)
    initial_scope = initial_scope.title(params[:title]) if params[:title].present?
    initial_scope = initial_scope.chosen if params[:chosen].present?
    initial_scope = initial_scope.where(status: params[:status]) if params[:status].present?
    
    if params[:created_at].present?
      date = Date.strptime(params[:created_at], "%d.%m.%y")
      initial_scope = initial_scope.find_by_created_day(date)
    end
    initial_scope
  end
end