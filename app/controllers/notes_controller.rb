class NotesController < ApplicationController
  before_action :require_login

  def index
    @notes = current_user.notes.where(active: true).all.reverse
  end

  def edit
    @note = current_user.notes.where(active: true).find(note_id)
  end

  def update
    @note = current_user.notes.where(active: true).find(note_id)
    @note.assign_attributes(note_params)

    save_note(@note) { |note| redirect_to(edit_note_path(note)) }
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(note_params)

    save_note(@note) { |_| redirect_to(new_note_path) }
  end

  def destroy
    @note = current_user.notes.find(note_id)
    @note.update_attribute(:active, false)

    redirect_to(notes_path)
  end

  private

  def note_params
    params
      .require(:note)
      .permit(:title, :content)
  end

  def note_id
    Integer(params[:id])
  end

  def save_note(note)
    if note.save
      redirect_to(notes_path)
    else
      flash[:errors] = note.errors.full_messages
      yield(note)
    end
  end
end
