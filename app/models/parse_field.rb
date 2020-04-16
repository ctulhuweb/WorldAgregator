class ParseField < ApplicationRecord
  belongs_to :site

  validates :name, presence: true
  validates :selector, presence: true

  enum field_type: { custom: "custom", link: "link" }, _prefix: :type
end
