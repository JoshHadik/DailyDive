$(document).on('turbolinks:load page:change', () => {
  // Exit editable text editor mode (focus) on enter instead of adding a new line.
  $('.editable-text').on('keydown', (e) => {
    if (e.keyCode === 13) {
      e.preventDefault();
      $(e.currentTarget).blur();
    }
  });

  // Properly paste text into editable text
  $('.editable-text').on('paste', (e) => {
    e.preventDefault();
    EditableTextHelper.handleContentEditablePaste(e)
  });

  // Disable dragging and dropping text/images into editable text.
  $('.editable-text').on('dragover drop', (e) => {
    e.preventDefault();
    return false;
  });

  // Store original value when focusing in on specific editable text (used to determine if text was changed and patch request should be sent on focusout.)
  $('.editable-text').on('focus', (e) => {
    const $target = $(e.currentTarget)
    $target.attr('data-original-value', $target.text())
  })

  // Send patch request for resource if content was changed.
  $('.editable-text').on('focusout', (e) => {
    const $target = $(e.currentTarget)

    // Empty all content of text if editable text is empty (otherwise certain browsers fill in a default <br> or <p> value.)
    if (!$target.text().trim().length) {
      $target.empty();
    }

    // Send patch request if text was changed.
    if ($target.data('original-value') != $target.text()) {
      EditableTextHelper.patchResource(e);
    }

    $target.removeAttr('data-original-value')
  });

  // Update all other divs tagged with the same dynamic-tag as the current text being edited. (So if you have two elements on one page that display the same title property of a resource, both will be updated in real time when you edit the text of one.)
  $('.editable-text').on('input', (e) => {
    const $target = $(e.currentTarget)
    const newValue = $target.text()
    const dynamicTag = $target.data('dynamicTag')

    $(`[data-dynamic-tag='${dynamicTag}']`).not($target).text(newValue)
  })
})
