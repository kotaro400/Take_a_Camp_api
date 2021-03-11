FactoryBot.define do
  factory :user do
    sequence(:name){|n| "user_#{n}" }
    password { "password" }
    team { Team.find(1) }

    trait :in_team_2 do
      team { Team.find(2) }
    end
  end
end
