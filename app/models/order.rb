class Order < ApplicationRecord
  belongs_to :user
  belongs_to :tariff

  enum status: { wait: 'wait', cancel: 'cancel', success: 'success', active: 'active' }, _prefix: :status
end
