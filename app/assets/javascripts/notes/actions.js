(function () {
  DELETE_ACTION_CLASS = '.js-note-actions--delete'
  TAG_ACTION_CLASS = '.js-note-actions--tag'

  DELETE_CONFIRM_FORM_CLASS = '.js-delete-confirm'
  ADD_TAG_CLASS = '.js-add-tag'
  ACTION_BUTTONS_CLASS = '.js-note--action-buttons'
  TAG_FORM_CLASS = '.js-tag-form'
  CANCEL_BUTTON_CLASS = '.js-cancel-button';

  function onCancelButtonClick(event) {
    event.preventDefault();
    event.stopPropagation();

    var $cancelButton = $(event.currentTarget);
    var $containerForm = $cancelButton.closest('.js-action-form');
    var $noteActionButtons = $containerForm.siblings(ACTION_BUTTONS_CLASS);

    $containerForm.trigger('custom:hide');

    $containerForm.addClass('hide');
    $noteActionButtons.removeClass('hide');
  }

  function onDeleteAction(event) {
    event.preventDefault();
    event.stopPropagation();

    $target = $(event.currentTarget);
    $actionButtons = $target.closest(ACTION_BUTTONS_CLASS);
    $messageConfirmation = $actionButtons.siblings(DELETE_CONFIRM_FORM_CLASS);

    $actionButtons.addClass('hide');
    $messageConfirmation.removeClass('hide');
  }

  function onAddTagAction(event) {
    var $target = $(event.currentTarget);
    var $actionButtons = $target.closest(ACTION_BUTTONS_CLASS);
    var $tagForm = $actionButtons.siblings(ADD_TAG_CLASS);
    var $chips = $tagForm.find('.chips');

    event.preventDefault();
    event.stopPropagation();

    $actionButtons.addClass('hide');
    $tagForm.removeClass('hide');

    $chips.trigger('tags:show');
  }

  function onHide(event) {
    var $target = $(event.currentTarget);

    $target
      .find('.chips')
      .trigger('tags:update');
  }

  $(CANCEL_BUTTON_CLASS).click(onCancelButtonClick);
  $(DELETE_ACTION_CLASS).click(onDeleteAction);
  $(TAG_ACTION_CLASS).click(onAddTagAction);

  $(ADD_TAG_CLASS).on('custom:hide', onHide);
})();
