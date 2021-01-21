require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it "名前、メール、パスワードがある場合、有効である" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "名前が空白の場合、無効である" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "メールが空白の場合、無効である" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "重複したメールアドレスの場合、無効である" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.build(:user, email: user1.email)
      user2.valid?
      expect(user2.errors[:email]).to include("を入力してください")
    end

    it "パスワードがない場合、無効である" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  end
end
