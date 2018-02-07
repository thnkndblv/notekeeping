class NotesController < ApplicationController
  before_action :require_login

  def index
    @notes = current_user.notes.where(active: true).all.reverse
  end

  def show
    tags = current_user
      .notes
      .where(active: true, id: note_id)
      .select(*query_fields)
      .first

    render json: tags
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
      .permit(:title, :content, tags: [])
  end

  def query_fields
    allowed = %(tags)

    params
      .require(:fields)
      .tap do |fields|
        fields.each do |field|
          raise ArgumentError, "Invalid field: '#{field}'" unless allowed.include?(field)
        end
      end
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
