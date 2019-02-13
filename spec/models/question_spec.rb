RSpec.describe Question, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:journal) }
  end
end
