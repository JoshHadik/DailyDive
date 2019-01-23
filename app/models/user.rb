class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  has_one :journal, dependent: :destroy #TT

  def get_or_create_journal
    self.journal || create_starter_journal
  end #TT

  private

  def create_starter_journal
    journal = Journal.new(title: "Daily Dive", caption: "Take control of your life one day at a time!")

    journal.questions << [
      Question.new(body: "What are you grateful for?", position: 1),
      Question.new(body: "What were some highlights from today?", position: 2),
      Question.new(body: "What was your biggest struggle of the day?", position: 3),
      Question.new(body: "What do you think led to that struggle?", position: 4),
      Question.new(body: "How can you overcome that struggle in the future?", position: 5),
      Question.new(body: "Overall, how would you say today went?",  position: 6)
    ]

    self.journal = journal
  end #PT (through #get_or_create_journal)
end
