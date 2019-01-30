class Resources::JournalsController < ApplicationController
  before_action :set_journal

  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.html { redirect_to @journal, notice: 'Journal was successfully updated.' }
        format.json { render json: @journal }
      else
        format.html { render :edit }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @journal.destroy
    respond_to do |format|
      format.html { redirect_to journals_url, notice: 'Journal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_journal
    @journal = Journal.find(params[:id])
  end
  
  def journal_params
    params.require(:journal).permit(:title, :caption)
  end
end
