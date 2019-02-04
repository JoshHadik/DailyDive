class JournalSeed
  @journal_data = {
    title: "Daily Dive",
    caption: "Take control of your life one day at a time!"
  }

  @seed_questions = [
    "What are you grateful for?",
    "What were some highlights from today?",
    "What was your biggest struggle of the day?",
    "What do you think led to that struggle?",
    "How can you overcome that struggle in the future?",
    "Overall, how would you say today went?"
  ]

  def self.build_initial_journal(user)
    journal = Journal.new(@journal_data)
    seed_questions(journal)
    user.journal = journal
  end

  private

  def self.seed_questions(journal)
    @seed_questions.each_with_index do |text, i|
      journal.questions << new_question(text, i+1)
    end
  end

  def self.new_question(body, position)
    Question.new(body: body, position: position)
  end
end
