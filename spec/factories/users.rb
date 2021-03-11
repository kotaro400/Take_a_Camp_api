FactoryBot.define do
  factory :user do
    sequence(:name){|n| "user_#{n}" }
    password { "password" }
    team { Team.find(1) }
  end
end
