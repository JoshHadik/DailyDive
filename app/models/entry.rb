class Entry < ApplicationRecord
  belongs_to :journal
  has_many :responses, dependent: :destroy

  def create_response(options={})
    Response.create(entry: self, **options)
  end
end
