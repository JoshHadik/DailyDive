class Journal < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :questions

  def new_question(options={})
    Question.new(journal: self, **options)
  end

  def create_question(question_params = {})
    new_question(question_params).save
  end
end
