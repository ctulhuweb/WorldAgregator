class Tariff < ApplicationRecord
  has_many :orders

  monetize :price_cents

  validates :count_sites, numericality: { greater_than: 0 }
  validates :parse_interval, numericality: { greater_than: 0 }
  validates :title, presence: true

  scope :active, ->  { where(active: true) }
end
