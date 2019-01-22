RSpec.describe User, type: :model do
  it { is_expected.to have_many(:journals).dependent(:destroy) }
end
