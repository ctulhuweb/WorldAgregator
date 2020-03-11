class Order < ApplicationRecord
  belongs_to :user
  belongs_to :tariff

  enum status: { wait: 'wait', cancel: 'cancel', success: 'success' }, _prefix: :status
end
