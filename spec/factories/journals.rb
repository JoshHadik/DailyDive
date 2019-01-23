FactoryBot.define do
  factory :journal do
    user_id { FactoryBot.create(:user).id }
    title { "Weekly Wire" }
    caption { "Your Weekly Reflection" }
  end
end
