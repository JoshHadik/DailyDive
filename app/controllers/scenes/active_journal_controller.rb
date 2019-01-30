class Scenes::ActiveJournalController < SceneController
  before_action :authenticate_user!
  before_action :set_entry, only: [ :previous, :next ]

  def scene
    if journal_in_progress?
      set_entry and set_response
    else
      new_entry and redirect_to_first_question
    end
  end

  def next
    if on_last_question?
      redirect_to scene_path(:journal_entry, @entry)
    else
      redirect_to_question(+1)
    end
  end

  def previous
    if on_first_question?
      exit_entry
    else
      redirect_to_question(-1)
    end
  end

  def exit_entry
    should_delete_entry = true

    @entry.responses.each do |response|
      should_delete_entry = false if !response.body.nil?
    end

    delete_entry if should_delete_entry
    redirect_to scene_path(:current_journal)
  end

  private

  def delete_entry
    @entry.destroy
  end

  def new_entry
    @entry = current_journal.create_entry_with_questions
  end

  def set_entry
    @entry = current_journal.entries.find(params[:entry])
  end

  def set_response
    @response = @entry.responses.find_by(position: params[:question])
  end

  def journal_in_progress?
    params[:entry]
  end

  def redirect_to_first_question
    redirect_to scene_path(:active_journal, entry: @entry.id, question: 1)
  end

  def on_first_question?
    params[:question].to_i == 1
  end

  def on_last_question?
    last_question.position == params[:question].to_i
  end

  def last_question
    @entry.responses.order(position: :asc).last
  end

  def redirect_to_question(val)
    redirect_to scene_path(:active_journal, {
      entry: @entry.id,
      question: params[:question].to_i + val
    })
  end
end
