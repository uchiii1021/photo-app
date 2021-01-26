require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe '#create' do
    it "タイトル・画像がある場合、有効である" do
      user = FactoryBot.build(:photo)
      expect(user).to be_valid
    end

    it "タイトルが空白の場合、無効である" do
      user = FactoryBot.build(:photo, title: nil)
      user.valid?
      expect(user.errors[:title]).to include("を入力してください")
    end

    it "画像が空白の場合、無効である" do
      user = FactoryBot.build(:photo, image: nil)
      user.valid?
      expect(user.errors[:image]).to include("を入力してください")
    end
  end
end