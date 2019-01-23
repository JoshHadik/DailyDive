class Scenes::MyJournalsController < Scenes::BaseController
  before_action :authenticate_user!

  def scene
    @user = current_user
    @journals = @user.journals
    @new_journal = Journal.new(owner: @user)
  end
end
