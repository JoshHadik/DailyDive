RSpec.describe Response, type: :model do
  it { is_expected.to belong_to(:entry) }
end
