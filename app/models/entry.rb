class Entry < ApplicationRecord
  belongs_to :journal #TT
  has_many :responses, dependent: :destroy #TT

  def create_response(options={})
    Response.create(**options, entry: self)
  end #TT

  def create_response_from_question(question, position)
    create_response(question: question.body, position: position)
  end #TT

  def create_responses_from_questions(*questions)
    questions.each_with_index.map do |question, index|
      create_response_from_question(question, index + 1)
    end
  end #TT
end
