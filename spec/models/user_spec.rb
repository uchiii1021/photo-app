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

    it "名前が11文字以上の場合、無効である" do
      user = FactoryBot.build(:user, name: "あいうえおかきくけこさ")
      user.valid?
      expect(user.errors[:name]).to include("は10文字以内で入力してください")
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
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    it "パスワードがない場合、無効である" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "確認パスワードがない場合、無効である" do
      user = FactoryBot.build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include()
    end

    it "確認パスワードがない場合、無効である" do
      user = FactoryBot.build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include()
    end
    
    it "パスワードが5文字以下の場合、無効である" do
      user = FactoryBot.build(:user, password: "abc12")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "パスワードが21文字以上の場合、無効である" do
      user = FactoryBot.build(:user, password: "abcdefghijklmn1234567890abcdefg")
      user.valid?
      expect(user.errors[:password]).to include("の長さは6文字から20文字の間にして下さい。半角英字小文字(a-z)、数字(0-9)を少なくともひとつずつ組み合わせてください。")
    end

    it "パスワードに半角英数字が含まれない場合、無効である" do
      user = FactoryBot.build(:user, password: "1234567")
      user.valid?
      expect(user.errors[:password]).to include("の長さは6文字から20文字の間にして下さい。半角英字小文字(a-z)、数字(0-9)を少なくともひとつずつ組み合わせてください。")
    end

    it "パスワードに数字が含まれない場合、無効である" do
      user = FactoryBot.build(:user, password: "abcdefg")
      user.valid?
      expect(user.errors[:password]).to include("の長さは6文字から20文字の間にして下さい。半角英字小文字(a-z)、数字(0-9)を少なくともひとつずつ組み合わせてください。")
    end
  end
end
