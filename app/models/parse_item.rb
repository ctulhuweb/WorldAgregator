class ParseItem < ApplicationRecord
  belongs_to :site
  
  acts_as_taggable_on :tags

  enum status: { new: "new", viewed: "viwed", deleted: "deleted" }, _prefix: :status

  scope :search, -> (search) { where("data->>'Title' like ?", "%#{search}%")}

  validates :data, presence: true
  validates :status, presence: true
end
