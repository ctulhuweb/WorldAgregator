class Site < ApplicationRecord
  has_many :parse_fields, dependent: :destroy
  has_many :parse_items, dependent: :destroy, foreign_key: "site_id"
  belongs_to :aggregator

  validates :name, presence: true
  validates :url, presence: true,
                  format: { with: /\b((http|https):\/\/?)[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/?))/ }
  validates :main_selector, presence: true

  accepts_nested_attributes_for :parse_fields

  scope :active, -> { where(active: true) }
  scope :not_active, -> { where(active: false) }
end
