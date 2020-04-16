require "rails_helper"

RSpec.describe User, type: :model do
  describe "create" do
    context "is invalid" do
      before(:each) do
        @user = build(:user) 
      end

      it "without password" do
        @user.password = nil
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it "without email" do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

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
    subject { build(:user) }
    it "has many sites" do
      assc = described_class.reflect_on_association(:aggregators)
      expect(assc.macro).to eq :has_many
    end
  end

  describe ".has_new_items?" do
    it "return true if any parse item has status 'new'" do
      user = create(:user)
      ag = create(:aggregator, user: user)
      sites = create_list(:site, 2, :with_new_parse_items, aggregator: ag)
      expect(user.has_new_items?).to eq true
    end

    it "return false if dont has parse items with status 'new'" do
      expect(build(:user).has_new_items?).to eq false
    end
  end

end