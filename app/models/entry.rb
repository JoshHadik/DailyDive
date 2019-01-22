class Entry < ApplicationRecord
  belongs_to :journal #TT
  has_many :responses, dependent: :destroy #TT

  def create_response(options={})
    Response.create(entry: self, **options)
  end
end
