RSpec.describe Response, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:entry) }
  end
end
