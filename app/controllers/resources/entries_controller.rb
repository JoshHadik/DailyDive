class Resources::EntriesController < ApplicationController
  before_action :set_entry

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
      format.js { }
    end
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end
  
  def entry_params
    params.require(:entry).permit(:journal_id)
  end
end
