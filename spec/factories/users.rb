FactoryBot.define do
  factory :user do
    name {"山田"}
    email {"tarou@test.com"}
    password {"test1234"}
    password_confirmation {"test1234"}
    confirmed_at { Date.today }
  end
end
