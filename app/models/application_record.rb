class ApplicationRecord < ActiveRecord::Base

  def self.paginate(page, per_page)
    offset((page - 1) * per_page).limit(per_page)
  end

  self.abstract_class = true
end
