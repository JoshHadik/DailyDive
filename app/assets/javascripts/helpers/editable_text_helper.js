const EditableTextHelper = {
  // Insert Plain Text rather than HTML when pasting into editable text
  insertPlainTextAtCursor(text) {
    var sel, range, html;
    if (window.getSelection) {
      sel = window.getSelection();
      if (sel.getRangeAt && sel.rangeCount) {
        range = sel.getRangeAt(0);
        range.deleteContents();
        range.insertNode(document.createTextNode(text));
      }
    } else if (document.selection && document.selection.createRange) {
      document.selection.createRange().text = text;
    }
  },

  // Copy clipboard data from event and paste into editable text.
  setEventClipboardData(e) {
    const clipboardData = e.clipboardData || e.originalEvent.clipboardData
    if (clipboardData && clipboardData.getData) {
      const text = clipboardData.getData("text/plain")
      document.execCommand("insertHTML", false, text)
      return true
    } else {
      return false
    }
  },

  // Copy clipboard data from window and paste into editable text.
  setWindowClipboardData(e) {
    const clipboardData = window.clipboardData
    if (clipboardData && clipboardData.getData) {
      const text = clipboardData.getData("Text")
      this.insertPlainTextAtCursor(text);
      return true
    } else {
      return false
    }
  },

  // Copy clipboard data from event OR window and paste into editable text.
  handleContentEditablePaste(e) {
    e.preventDefault();
    this.setEventClipboardData(e) || this.setWindowClipboardData()
  },

  // Build ajax request for patch resource function.
  sendPatchRequest(url, resourceType, attribute, updatedValue) {
    var ajaxRequest = {
      type: 'PATCH',
      url: url,
      dataType: 'json',
      success: (data) => { console.log(data) },
      data: {}
    };

    ajaxRequest.data[resourceType] = {}
    ajaxRequest.data[resourceType][attribute] = updatedValue

    $.ajax(ajaxRequest)
  },

  // Update a specific attribute of a resource.
  patchResource(e) {
    const $editableText = $(e.currentTarget)
    const $editableTextContainer = $editableText.parent();
    const $action = $editableTextContainer.find("[name='_action']")

    const url = $action.attr('url');
    const resourceType = $action.attr('resourcetype');
    const attribute = $action.attr('attribute');
    const updatedValue = $editableText.text();

    this.sendPatchRequest(url, resourceType, attribute, updatedValue)
  }
}
