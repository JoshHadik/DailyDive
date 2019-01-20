class Scenes::JournalEntryController < ApplicationController
  before_action :authenticate_user!

  def scene
    @journal = Journal.find(params[:id])
    @entry = @journal.entries.find(params[:entry_id])
    @responses = @entry.responses.order(position: :asc)
  end
end
