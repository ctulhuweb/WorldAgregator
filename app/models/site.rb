class Site < ApplicationRecord
  has_many :parse_fields, inverse_of: :site, dependent: :destroy
  has_many :parse_items, foreign_key: "site_id"
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true,
                  format: { with: /\b((http|https):\/\/?)[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/?))/ }
  validates :main_selector, presence: true

  accepts_nested_attributes_for :parse_fields, allow_destroy: true, reject_if: proc { |attrs| attrs["name"].blank? }

  scope :active, -> { where(active: true) }
  scope :not_active, -> { where(active: false) }

  def info
    "Name: #{name} Url: #{url} Active: #{active}"
  end
end
