$(document).on('turbolinks:load page:change', () => {
  // Remove list item when question is deleted
  $(".delete-question-button").on("click", (e) => {
    $(e.currentTarget).closest('li').remove();
  })

  // Add active class to li when internal editable text is focused on.
  $(".edit-question-item .editable-text").on("focus", (e) => {
    $(e.currentTarget).closest('li').addClass("active");
  })

  // Remove active class on li when editable text is focused out UNLESS mouse is hovering over the delete button (otherwise the active class for the li is removed and the delete button dissappears before the delete button click is triggered, rendering the delete button unclickable. )
  $(".edit-question-item").on("focusout", (e) => {
    if($('.delete-question-button' + ':hover').length) {
      return;
    }
    $(e.target).closest('li').removeClass("active");
  })
})
