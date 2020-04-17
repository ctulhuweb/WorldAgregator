require "rails_helper"

RSpec.describe 'Aggregator Management', type: :request do
  before(:each) do
    @user = create(:user)
    @aggregator = create(:aggregator, user: @user)
    sign_in @user
  end

  describe '#index' do
    subject { get aggregators_path }

    before(:each) do
      subject
    end

    it do
      expect(response).to have_http_status(:success)
    end
  end
  describe '#new' do
    subject { get new_aggregator_path }

    before(:each) { subject }

    it do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    let!(:attrs) { attributes_for(:aggregator) }
    subject { post aggregators_path, params: { aggregator: attrs, format: :js }}
  
    it "new aggregator" do
      expect { subject }.to change(@user.aggregators, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    context "invalid params" do
      let(:attrs) { attributes_for(:aggregator, title: "") }
      it "return alert" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#destroy' do
    subject { delete aggregator_path(@aggregator), params: { format: :js }}
    
    it "delete aggregator" do
      expect { subject }.to change(@user.aggregators, :count).from(1).to(0)
    end
  end

  describe '#edit' do
    subject { get edit_aggregator_path(@aggregator) }

    before(:each) { subject }

    it do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    let!(:attrs) { attributes_for(:aggregator) }
    subject { put aggregator_path(@aggregator), params: { aggregator: attrs, format: :js }}

    it "changes attributes" do
      expect {
        subject
      }.to change { @aggregator.reload.title } 
    end

    context "invalid attrs" do
      let(:attrs) { attributes_for(:aggregator, title: "") }
      it "return error" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end