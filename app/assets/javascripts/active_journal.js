function placeCaretAtEnd(el) {
    el.focus();
    if (typeof window.getSelection != "undefined"
            && typeof document.createRange != "undefined") {
        var range = document.createRange();
        range.selectNodeContents(el);
        range.collapse(false);
        var sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
    } else if (typeof document.body.createTextRange != "undefined") {
        var textRange = document.body.createTextRange();
        textRange.moveToElementText(el);
        textRange.collapse(false);
        textRange.select();
    }
}

$(document).on('turbolinks:load page:change', () => {
  $mainTextInput = $(".active-journal .response-body .editable-text")
  if ($mainTextInput.length > 0) {
    placeCaretAtEnd($mainTextInput[0]);
  }

  $mainTextInput.on('keydown', (e) => {
    if (e.keyCode === 13) {
      console.log("ERE")
      e.preventDefault();
      $('.next')[0].click();
      // $(e.currentTarget).blur();
    }
  })
})
