RSpec.describe User, type: :model do
  context "associations" do
    it { is_expected.to have_one(:journal).dependent(:destroy) }
  end

  subject do
    FactoryBot.create(:user)
  end

  describe '#get_or_create_journal' do
    context 'when user already has a journal' do
      let(:journal) do
        FactoryBot.create(:journal)
      end

      before do
        subject.journal = journal
      end

      it 'returns the previously set journal' do
        expect(subject.get_or_create_journal).to eq(journal)
      end
    end

    context 'when user does not have a journal' do
      it 'creates a new journal' do
        expect { subject.get_or_create_journal }
          .to change(subject, :journal).from(nil)
        expect(subject.get_or_create_journal).to be_an_instance_of(Journal)
      end

      it 'creates a new journal with some preset information' do
        subject.get_or_create_journal
        expect(subject.journal.questions).to_not be_empty
        expect(subject.journal.title).to_not be_empty
        expect(subject.journal.caption).to_not be_empty
      end
    end
  end
end
