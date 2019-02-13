FactoryBot.define do
  factory :response do
    entry_id { FactoryBot.create(:entry).id }
    question { "How are you?" }
    body { "I am good" }
    sequence(:position) { |index| index }
  end
end
