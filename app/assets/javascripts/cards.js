const Card = {
  show(cardButton) {
    const $cardButton = $(cardButton);
    const cardTag = $cardButton.data("cardTag")
    const $cardCanvas = $(`[data-card-canvas='${cardTag}']`);

    $("body").prepend("<div class='cover'></div>")
    $(".cover").animate({"opacity": "0.5"}, 300)

    $cardCanvas.css("top", "100vh");
    $cardCanvas.toggleClass("active");
    $cardCanvas.animate({"top": "0"}, 300, "swing")
  },

  hide(callback) {
    const $cardCanvas = $('.card-canvas.active');

    $cardCanvas.animate({"top": "100vh"}, 300, "swing", () => {
      $cardCanvas.removeClass("active");
    });

    $cardCanvas.promise().done(() => {
      if(typeof callback !== 'undefined'){
        callback();
      };
    })

    $(".cover").animate({"opacity": "0"}, 300, () => {
      $(".cover").remove();
    });
  }
}

$(document).on('turbolinks:load page:change', () => {
  // Scroll corresponding Card View in from bottom when ShowCard action is activated.
  ActionHelper.getElementByAction('showCard').on('click', (e) => {
    e.preventDefault();
    Card.show(e.currentTarget)
  });

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

  // Close card before redirecting to link
  $(".card a").on('click', (e) => {
    e.preventDefault();
    Card.hide(() => {
      window.location = $(e.currentTarget).attr("href");
    })
  })

  // Close card view when surrounding area of close button are clicked.
  $(".card-canvas").on('click', (e) => {
    if ($(e.target).is(e.currentTarget) || $(e.target).hasClass("close")) {
      Card.hide()
    }
  })
})
