class SharesController < ApplicationController
  before_action :require_login

  def index
    shares = User
      .joins(:shares)
      .where.not('shares.user_id = shares.to_user_id')
      .where(shares: { active: true, note_id: note_id })
      .select('users.email', 'shares.permission')
      .all

    render json: shares
  end

  def create
    param = share_params

    user = User.find_by(email: param[:email].downcase)
    if user && Note.find(note_id).user.id != user.id
      Share.transaction do
        share = Share.find_or_initialize_by(
          note_id: note_id,
          user_id: current_user.id,
          to_user_id: user.id
        )

        share[:permission] = param[:permission]
        share[:active] = true
        share.save
      end
    end

    redirect_to root_path
  end

  def destroy
    share = Share.find_by(
      id: share_id,
      user_id: current_user.id,
      note_id: note_id
    )

    if share
      share.update_attributes(active: false)
    end

    redirect_to root_path
  end

  private

  def note_id
    Integer(params[:note_id])
  end

  def share_id
    Integer(params[:id])
  end

  def share_params
    params
      .require(:share)
      .permit(:email, :permission)
  end
end
