RSpec.describe Journal, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:owner)
                        .class_name("User")
                        .with_foreign_key(:user_id) }
    it { is_expected.to have_many(:questions).dependent(:destroy) }
    it { is_expected.to have_many(:entries).dependent(:destroy) }
  end

  subject do
    FactoryBot.create(:journal)
  end

  describe '#ordered_questions' do
    let(:questions) do
      [
        FactoryBot.create(:question, position: 2),
        FactoryBot.create(:question, position: 3),
        FactoryBot.create(:question, position: 1)
      ]
    end

    let(:ordered_questions) do
      subject.ordered_questions
    end

    before do
      subject.questions.push(*questions)
    end

    it 'sorts questions by position' do
      expect(ordered_questions[0]).to eq(questions[2])
      expect(ordered_questions[1]).to eq(questions[0])
      expect(ordered_questions[2]).to eq(questions[1])
    end
  end

  describe '#create_question' do
    let(:question_attributes) do
      FactoryBot.attributes_for(:question, journal_id: nil)
    end

    let(:question) do
      subject.create_question(question_attributes)
    end

    it 'creates a question with the correct parameters' do
      expect(question.body).to eq(question_attributes[:body])
    end

    it 'creates a question that belongs to the correct journal' do
      expect(question.journal_id).to eq(subject.id)
      expect(subject.questions).to include(question)
    end
  end

  describe '#create_entry_with_questions' do
    before do
      subject.questions.push(*questions)
    end

    let(:questions) do
      [
        FactoryBot.create(:question),
        FactoryBot.create(:question),
        FactoryBot.create(:question)
      ]
    end

    let(:entry) do
      subject.create_entry_with_questions
    end

    it 'creates a new entry that belongs to the correct journal' do
      expect(entry.journal_id).to eq(subject.id)
      expect(subject.entries).to include(entry)
    end

    it 'creates responses for new entry based on the journals questions' do
      questions.each_with_index do |question, index|
        response = entry.responses[index]
        expect(response.question).to eq(question.body)
        expect(response.position).to eq(question.position)
      end
    end
  end
end
