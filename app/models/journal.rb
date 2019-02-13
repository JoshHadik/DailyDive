class Journal < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id" #TT
  has_many :questions, dependent: :destroy #TT
  has_many :entries, dependent: :destroy #TT

  def ordered_questions
    questions.order(position: :asc)
  end #TT

  def create_question(question_params = {})
    Question.create(question_params.merge(journal: self))
  end #TT

  def create_entry_with_questions
    Entry.create(journal: self).tap do |entry|
      entry.create_responses_from_questions(*questions)
    end
  end #TT
end
