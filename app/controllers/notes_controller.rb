class NotesController < ApplicationController
  before_action :require_login

  def index
    @notes = current_user.notes.where(active: true).all.reverse
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(note_params)

    if @note.save
      redirect_to(notes_path)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to(new_note_path)
    end
  end

  def destroy
    @note = current_user.notes.find_by(id: params[:id])
    @note.update_attribute(:active, false)

    redirect_to(notes_path)
  end

  private

  def require_login
    redirect_to(login_path) unless logged_in?
  end

  def note_params
    params
      .require(:note)
      .permit(:title, :content)
  end
end
