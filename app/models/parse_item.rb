class ParseItem < ApplicationRecord
  belongs_to :site
  
  acts_as_taggable_on :tags

  enum status: { new: "new", viewed: "viwed", deleted: "deleted" }, _prefix: :status

  scope :title, -> (title) { where("data->>'Title' like ?", "%#{title}%")}
  scope :chosen, -> { where(chosen: true) }
  scope :find_by_created_day, -> (date) { where(created_at: date.beginning_of_day..date.end_of_day) }

  validates :data, presence: true
  validates :status, presence: true
end
