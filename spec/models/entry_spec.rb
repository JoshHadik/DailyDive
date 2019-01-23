RSpec.describe Entry, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:journal) }
    it { is_expected.to have_many(:responses).dependent(:destroy) }
  end

  subject do
    FactoryBot.create(:entry)
  end

  describe '#create_response' do
    let(:response_attributes) do
      FactoryBot.attributes_for(:response, entry_id: nil)
    end

    let(:response) do
      subject.create_response(response_attributes)
    end

    it 'creates a response with the correct attributes' do
      expect(response.question).to eq(response_attributes[:question])
      expect(response.body).to eq(response_attributes[:body])
      expect(response.position).to eq(response_attributes[:position])
    end

    it 'creates a response that belongs to the correct entry' do
      expect(response.entry_id).to eq(subject.id)
      expect(subject.responses).to include(response)
    end
  end

  describe '#create_response_from_question' do
    let(:question) do
      FactoryBot.create(:question)
    end

    let(:response) do
      subject.create_response_from_question(question)
    end

    it 'creates a response with the correct attributes' do
      expect(response.question).to eq(question.body)
      expect(response.position).to eq(question.position)
    end

    it 'creates a response that belongs to the correct entry' do
      expect(response.entry_id).to eq(subject.id)
      expect(subject.responses).to include(response)
    end
  end

  describe '#create_response_from_questions' do
    let(:questions) do
      [
        FactoryBot.create(:question),
        FactoryBot.create(:question),
        FactoryBot.create(:question)
      ]
    end

    let(:responses) do
      subject.create_responses_from_questions(*questions)
    end

    it 'creates responses based on the input questions' do
      questions.each_with_index do |question, index|
        response = responses[index]
        expect(response.question).to eq(question.body)
        expect(response.position).to eq(question.position)
      end
    end
  end
end
