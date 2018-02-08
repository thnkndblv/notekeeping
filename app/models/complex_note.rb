class ComplexNote < SimpleDelegator
  def initialize(note, user)
    @note = note
    @user = user
    super(@note)

    ::NotePermissions.assign_permissions(self, user)
  end

  def share_list
    User
      .joins('INNER JOIN shares ON users.id=shares.to_user_id')
      .where.not('shares.user_id = shares.to_user_id')
      .where(
        shares: {
          active: true,
          note_id: id,
          user_id: @user.id
        }
      )
      .select('users.email', 'shares.permission', 'shares.id')
      .all
      .to_a
  end

  def query!
    raise "You have not permission for: read" unless read?
    Note
      .actives
      .where(id: id)
      .tap { |note| yield(note) }
  end

  def delete!
    raise "You have not permission for: update" unless delete?
    @note.update_attribute(:active, false)
  end
end
