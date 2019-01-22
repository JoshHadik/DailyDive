RSpec.describe Entry, type: :model do
  it { is_expected.to belong_to(:journal) }
  it { is_expected.to have_many(:responses).dependent(:destroy) }
end
