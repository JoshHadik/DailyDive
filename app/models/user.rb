class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :journals, dependent: :destroy #TT

  def create_journal(journal)
    journal.owner = self
    journal.save
    return journal
  end
end
