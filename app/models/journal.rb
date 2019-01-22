class Journal < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id" #TT
  has_many :questions, dependent: :destroy #TT
  has_many :entries, dependent: :destroy #TT

  def new_question(options={})
    Question.new(journal: self, **options)
  end

  def create_question(question_params = {})
    new_question(question_params).save
  end

  def create_entry
    entry = Entry.create(journal: self)
    questions.each_with_index do |question, index|
      entry.create_response(question: question.body, position: index + 1)
    end
    return entry
  end
end
