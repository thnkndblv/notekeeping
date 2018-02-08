(function ($, window, undefined) {
  function fetchTags(noteId) {
    var url = '/notes/' + noteId;

    return $.get({
      url: url,
      data: {
        fields: ['tags']
      }
    });
  }

  function updateTags(noteId, tags) {
    var url = '/notes/' + noteId;

    return $.ajax({
      url: url,
      method: 'PUT',
      dataType: 'json',
      data: { note: { tags: tags } }
    });
  }

  function onTagsVisible(event) {
    event.preventDefault();
    event.stopPropagation();

    var $chips = $(event.currentTarget);
    var noteId = $chips.data('noteId');

    fetchTags(noteId)
      .then(function (response) {
        var tags = (response && response['tags']) || [];
        tags = tags.map(function (item) { return { tag: item }; });

        $chips.material_chip({ data: tags });
      });
  }

  function onTagsUpdated(event, tag) {
    var $tags = $(event.currentTarget);
    var noteId = $tags.data('noteId');
    var tags = $tags.material_chip('data').map(function (tag) { return tag['tag']; });

    updateTags(noteId, tags);
  }

  $('.chips').on('tags:show', onTagsVisible);
  $('.chips').on('tags:update', onTagsUpdated);
})(jQuery, window);
