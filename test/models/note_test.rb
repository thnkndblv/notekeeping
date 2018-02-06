require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_a)
    @note = @user.notes.build(title: 'Test title', content: 'Test content')
  end

  test 'should be valid' do
    assert @note.valid?
  end

  test 'validates user_id is present' do
    @note.user_id = nil
    assert_not @note.valid?
  end

  test 'validates title is present' do
    @note.title = nil
    assert_not @note.valid?
  end

  test 'validates content is present' do
    @note.content = nil
    assert_not @note.valid?
  end

  test 'validates title length is at most 100 chars' do
    @note.title = 'a' * 101
    assert_not @note.valid?
  end
end
