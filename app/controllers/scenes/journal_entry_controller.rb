class Scenes::JournalEntryController < SceneController
  before_action :authenticate_user!

  def scene
    @entry = current_journal.entries.find(params[:id])
    @responses = @entry.ordered_responses

  end

  def delete_entry
    @entry = current_journal.entries.find(params[:id])
    @entry.destroy
    redirect_to '/'
  end
end
