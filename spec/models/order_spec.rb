require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it_behaves_like "has a association", :user, :belongs_to
    it_behaves_like "has a association", :tariff, :belongs_to
  end
end
