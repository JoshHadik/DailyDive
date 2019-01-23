class Journal < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id" #TT
  has_many :questions, dependent: :destroy #TT
  has_many :entries, dependent: :destroy #TT

  # def new_question(options={})
  #   Question.new(journal: self, **options)
  # end

  def create_question(question_params = {})
    Question.create(**question_params, journal: self)
  end #TT

  def ordered_questions
    questions.order(created_at: :asc)
  end

  def create_entry_with_questions
    Entry.create(journal: self).tap do |entry|
      entry.create_responses_from_questions(*ordered_questions)
    end
  end #TT
end
