FactoryBot.define do
  factory :photo do
    title {"テスト"}
    image {File.open("#{Rails.root}/spec/fixtures/images/test.JPG")}
    description {"テスト。これはテストです"}
    created_at {Date.today}
    user {FactoryBot.create(:user)}
  end
end
