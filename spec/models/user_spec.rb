RSpec.describe User, type: :model do
  it { is_expected.to have_one(:journal).dependent(:destroy) }
end
