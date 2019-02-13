class Entry < ApplicationRecord
  belongs_to :journal #TT
  has_many :responses, dependent: :destroy #TT

  def create_response(options={})
    Response.create(**options, entry: self)
  end #TT

  def create_response_from_question(question)
    create_response({
      question: question.body,
      position: question.position
    })
  end #TT

  def ordered_responses
    responses.order(created_at: :asc)
  end

  def create_responses_from_questions(*questions)
    questions.map do |question|
      create_response_from_question(question)
    end
  end #TT
end
