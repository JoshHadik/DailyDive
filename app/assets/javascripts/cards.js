const Card = {
  show(cardTag) {
    const $card = $(`.popup-cards #${cardTag}-card`)
    const $cardCanvas = this.renderCardCanvasWithCard($card)
    $('body').append($cardCanvas)

    $("body").prepend("<div class='cover'></div>")
    $(".cover").animate({"opacity": "0.5"}, 300)

    $cardCanvas.css("top", "100vh");
    $cardCanvas.toggleClass("active");
    $cardCanvas.animate({"top": "0"}, 300, "swing")
  },
  hide(callback) {
    const $cardCanvas = $('.card-canvas');

    $cardCanvas.animate({"top": "100vh"}, 300, "swing");

    $cardCanvas.promise().done(() => {
      $cardCanvas.remove();
      if(typeof callback !== 'undefined'){
        callback();
      };
    })

    $(".cover").animate({"opacity": "0"}, 300, () => {
      $(".cover").remove();
    });
  },
  renderCardCanvasWithCard($card) {
    return $(`
      <div class='card-canvas'>
        ${$card.clone().prop('outerHTML')}
        <p class="close">
          Close
        </p>
      </div>
    `)
  }
}

$(document).on('turbolinks:load page:change', () => {
  // Scroll corresponding Card View in from bottom when ShowCard action is activated.
  ActionHelper.getElementByAction('showCard').on('click', (e) => {
    e.preventDefault();
    const cardTag = $(e.currentTarget).data("cardTag");
    Card.show(cardTag);
  });

  // Add underline to close text when hovering over any area outside of the open card view.
  $("body").on('mouseover', '.card-canvas', (e) => {
    $(e.currentTarget).find(".close").addClass("jqhover")
  }).on('mouseout', (e) => {
    $(e.currentTarget).find(".close").removeClass("jqhover")
  })

  // Don't underline close button when cursor is over card.
  $("body").on('mouseover', '.card', (e) => {
    e.stopPropagation();
  })

  // Close card before redirecting to link
  $("body").on('click', '.card a.link', (event) => {
    event.preventDefault();
    Card.hide(() => {
      window.location = $(event.target).attr("href");
    })
  })

  // Close card view when surrounding area of close button are clicked.
  $("body").on('click', '.card-canvas', (e) => {
    if ($(e.target).is(e.currentTarget) || $(e.target).hasClass("close")) {
      Card.hide()
    }
  })
})
