class Aggregator < ApplicationRecord
  belongs_to :user
  has_many :sites, dependent: :destroy

  validates :title, presence: true
end
