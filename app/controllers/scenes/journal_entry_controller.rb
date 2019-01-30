class Scenes::JournalEntryController < SceneController
  before_action :authenticate_user!

  def scene
    @entry = current_journal.entries.find(params[:id])
    @responses = @entry.responses.order(position: :asc)
  end
end
