RSpec.describe Journal, type: :model do
  it { is_expected.to belong_to(:owner)
                      .class_name("User")
                      .with_foreign_key(:user_id) }
  it { is_expected.to have_many(:questions).dependent(:destroy) }
  it { is_expected.to have_many(:entries).dependent(:destroy) }
end
