RSpec.describe Question, type: :model do
  it { is_expected.to belong_to(:journal) }
end
