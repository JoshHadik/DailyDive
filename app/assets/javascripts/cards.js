$(document).on('turbolinks:load page:change', () => {
  // Scroll corresponding Card View in from bottom when ShowCard action is activated.
  ActionHelper.getElementByAction('showCard').on('click', (e) => {
    e.preventDefault();
    var $target = $(e.currentTarget);
    var cardTag = $target.data("cardTag")
    var $cardCanvas = $(`[data-card-canvas='${cardTag}']`);

    $("body").prepend("<div class='cover'></div>")
    $(".cover").animate({"opacity": "0.5"}, 300)

    $cardCanvas.css("top", '100vh');
    $cardCanvas.toggleClass("active");
    $cardCanvas.animate({"top": "0"}, 300, "swing")
  })

  // Add underline to close text when hovering over any area outside of the open card view.
  $(".card-canvas").on('mouseover', (e) => {
    $(e.currentTarget).find(".close").addClass("jqhover")
  }).on('mouseout', (e) => {
    $(e.currentTarget).find(".close").removeClass("jqhover")
  })

  // Don't underline close button when cursor is over card.
  $(".card").mouseover((e) => {
    e.stopPropagation();
  })

  // Close card view when surrounding area of close button are clicked.
  $(".card-canvas").on('click', (e) => {
    const $target = $(e.currentTarget)

    if ($(e.target).is($target) || $(e.target).hasClass("close")) {
      $target.animate({"top": "100vh"}, 300, "swing", function() {
        $target.removeClass("active");
      })

      $(".cover").animate({"opacity": "0"}, 300, function() {
        $(".cover").remove();
      })
    }
  })
})
