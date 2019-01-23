FactoryBot.define do
  factory :question do
    journal_id { FactoryBot.create(:journal).id }
    body { "I am good" }
    sequence(:position) { |index| index }
  end
end
