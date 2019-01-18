class Journal < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :questions

  def new_question
    Question.new(journal: self)
  end
end
