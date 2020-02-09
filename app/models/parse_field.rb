class ParseField < ApplicationRecord
  belongs_to :site

  validates :name, presence: true
  validates :selector, presence: true
end
