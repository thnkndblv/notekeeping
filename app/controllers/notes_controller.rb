class NotesController < ApplicationController
  before_action :require_login

  def index
    @notes = fetch_notes.select(&:read?)
  end

  def show
    note = fetch_notes(note_id: note_id).first.query! do |note|
      note.select(*query_fields)
    end

    render json: note.first
  end

  def edit
    @note = fetch_notes(note_id: note_id).first
  end

  def update
    @note = fetch_notes(note_id: note_id).first

    if @note.update? && @note.update_attributes(note_params)
      redirect_to(notes_path)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to(edit_note_path(@note))
    end
  end

  def new
    @note = current_user.notes.build
  end

  def create
    saved = nil
    ActiveRecord::Base.transaction do
      @note = current_user.notes.build(note_params)
      saved = @note.save
      Share.find_or_create_by(
        note_id: @note.id,
        user_id: @note.user_id,
        to_user_id: @note.user_id,
        permission: 'own'
      )
    end

    if saved
      redirect_to(notes_path)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to(new_note_path)
    end
  end

  def destroy
    fetch_notes(note_id: note_id).first.delete!

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

  def fetch_notes(note_id: nil)
    notes = Note
      .joins(:shares)
      .order(created_at: :desc)
      .distinct
      .where(
        notes: { active: true },
        shares: { active: true, to_user_id: current_user.id }
      )

    notes = notes.where(notes: { id: note_id }) if note_id

    notes.map { |n| ::ComplexNote.new(n, current_user) }
  end
end
