FactoryBot.define do
  factory :entry do
    sequence(:id) { |id| id }
    journal_id { FactoryBot.create(:journal).id }
  end
end
