class Scenes::ActiveJournalController < ApplicationController
  before_action :authenticate_user!

  def scene
    if params[:entry]
      @journal = Journal.find(params[:id])
      @entry = @journal.entries.find(params[:entry])
      @response = @entry.responses.find_by(position: params[:response])
    else
      start_new_entry
    end
  end

  def start_new_entry
    @journal = Journal.find(params[:id])
    @entry = @journal.create_entry

    redirect_to scenes_active_journal_path(@journal, entry: @entry.id, response: 1)
  end

  def next_question
    @journal = Journal.find(params[:id])
    @entry = @journal.entries.find(params[:entry])

    next_response = params[:response].to_i + 1

    if @entry.responses.order(position: :asc).last.position >= next_response
      redirect_to scenes_active_journal_path(@journal, entry: @entry.id, response: (next_response))
    else
      redirect_to scenes_journal_entry_path(@journal, @entry)
    end
  end

  def previous_question
    @journal = Journal.find(params[:id])
    @entry = @journal.entries.find(params[:entry])

    redirect_to scenes_active_journal_path(@journal, entry: @entry.id, response: (params[:response].to_i - 1))
  end

end
