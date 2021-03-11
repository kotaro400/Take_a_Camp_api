FactoryBot.define do
  factory :vote do
    association :user

    trait :in_team_2 do
      association :user, :in_team_2
    end
  end
end
