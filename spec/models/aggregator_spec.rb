require 'rails_helper'

RSpec.describe Aggregator, type: :model do
  describe '#new' do
    describe 'is invalid' do
      it_behaves_like "a model presence validation for", "title"
    end
  end

  describe 'Associations' do
    it_behaves_like "has a association", :user, :belongs_to
    it_behaves_like "has a association", :sites, :has_many
  end
end
