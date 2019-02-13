$(document).on('turbolinks:load page:change', () => {
  // Remove list item when question is deleted
  $(".edit-questions").on("click", ".delete-question-button", (e) => {
    $(e.currentTarget).closest('li').remove();
  })

  // Add active class to li when internal editable text is focused on.
  $(".edit-questions").on("focus", ".editable-text", (e) => {
    $(e.currentTarget).closest('li').addClass("active");
  })

  // Remove active class on li when editable text is focused out UNLESS mouse is hovering over the delete button (otherwise the active class for the li is removed and the delete button dissappears before the delete button click is triggered, rendering the delete button unclickable. )
  $(".edit-questions").on("focusout", ".edit-question-item", (e) => {
    if($(e.currentTarget).find('.delete-question-button' + ':hover').length) {
      return;
    }
    $(e.target).closest('.edit-question-item').removeClass("active");
  })
})
