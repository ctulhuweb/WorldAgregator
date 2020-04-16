require "rails_helper"

RSpec.describe User, type: :model do
  describe "create" do
    context "is invalid" do
      before(:each) do
        @user = build(:user) 
      end

      it_behaves_like "a model presence validation for", "password"

      it "with invalid email" do
        @user.email = "invalid.com@"
        @user.valid?
        expect(@user.errors[:email]).to include("is invalid")
      end
      
      it "with password length less 6" do
        @user.password = Faker::Internet.password(min_length: 3, max_length: 5)
        @user.valid?
        expect(@user.errors[:password].size).to eq(1)
      end
    end

    context "is valid" do
      it "with valid attributes" do
        expect(build(:user)).to be_valid
      end
    end
  end

  describe "Associations" do
    it_behaves_like "has a association", :sites, :has_many
    it_behaves_like "has a association", :orders, :has_many
  end

  describe 'istance methods' do
    before(:each) do
      @user = create(:user)
      @sites = create_list(:site, 2, :with_two_parse_items, user: @user)
    end

    it "#has_new_items" do
      expect(@user.has_new_items?).to eq true
    end

    it "#new_items" do
      expect(@user.new_items.count).to eq(4)
    end
  end

  describe 'attaches' do
    subject { build(:user, :with_avatar).avatar }
    it "#avatar" do
      is_expected.to be_a_instance_of(ActiveStorage::Attached::One)
    end
  end

end