(function () {
  var ACTION_BUTTON_CLASS = '.js-note-action-btn';
  var CANCEL_BUTTON_CLASS = '.js-cancel-button';

  function onCancelButtonClick(event) {
    event.preventDefault();
    event.stopPropagation();

    var $btn = $(event.currentTarget);
    var $cardAction = $btn.closest('.card-action');
    var $rows = $cardAction.find('.row');

    $btn.closest('.row').find('.chips').trigger('tags:update');

    $rows
      .addClass('hide')
      .filter('.js-action-buttons')
        .removeClass('hide');
  }

  var onActionButtonClick = function (event) {
    event.preventDefault();
    event.stopPropagation();

    var $btn = $(event.currentTarget);
    var $cardAction = $btn.closest('.card-action');
    var $rows = $cardAction.find('.row');

    $rows
      .addClass('hide')
      .filter($btn.data('action'))
        .removeClass('hide')
        .find('.chips')
        .trigger('tags:show');
  };

  $(ACTION_BUTTON_CLASS).click(onActionButtonClick);
  $(CANCEL_BUTTON_CLASS).click(onCancelButtonClick);
})();
