// $(document).on('turbolinks:load page:change', () => {
//   if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
//     $('body').addClass('mobile')
//    // some code..
//   }
//   if ($('body').hasClass('mobile')) {
//     $('.card').css({ 'min-height': window.innerHeight })
//   }
// })


const Card = {
  changeScreen($card, screenTag) {
    this.clearScreen($card);
    const $screen = $card.find(`#${screenTag}-screen`);
    $screen.addClass("active");
  },

  clearScreen($card) {
    const $activeScreen = $card.find('.screen.active');
    $activeScreen.removeClass('active');
  }
}


const PopupDisplay = {
  show(screenTag) {
    const $screen = $(`#${screenTag}-screen`);
    const $popupCanvas = $('.popup-canvas');

    $screen.addClass("active");

    $("body").prepend("<div class='cover'></div>")
    $(".cover").animate({"opacity": "0.5"}, 300)

    $popupCanvas.css("top", "100vh");
    $popupCanvas.addClass("active");
    $popupCanvas.animate({"top": "0"}, 300, "swing")
  },

  hide(callback) {
    const $activeScreen = $('.popup-card .screen.active');
    const $popupCanvas = $('.popup-canvas');

    $popupCanvas.animate({"top": "100vh"}, 300, "swing");

    $popupCanvas.promise().done(() => {
      $popupCanvas.removeClass("active");
      $activeScreen.removeClass('active');
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
  ActionHelper.getElementByAction('showPopupCard').on('click', (e) => {
    e.preventDefault();
    const screenTag = $(e.currentTarget).data("screenTag");
    PopupDisplay.show(screenTag);
  });

  ActionHelper.getElementByAction('changeCardScreen').on('click', (e) => {
    e.preventDefault();
    const $card = $(e.currentTarget).closest('.card');
    const screenTag = $(e.currentTarget).data("screenTag");
    Card.changeScreen($card, screenTag);
  });


  // Add underline to close text when hovering over any area outside of the open card view.
  $("body").on('mouseover', '.popup-canvas', (e) => {
    $(e.currentTarget).find(".close").addClass("jqhover")
  }).on('mouseout', (e) => {
    $(e.currentTarget).find(".close").removeClass("jqhover")
  })

  // Don't underline close button when cursor is over card.
  $("body").on('mouseover', '.popup-canvas .card', (e) => {
    e.stopPropagation();
  })

  // Close card before redirecting to link
  $("body").on('click', '.popup-canvas .card a.link', (event) => {
    event.preventDefault();
    PopupDisplay.hide(() => {
      window.location = $(event.target).attr("href");
    })
  })

  // Close card view when surrounding area of close button are clicked.
  $("body").on('click', '.popup-canvas', (e) => {
    if ($(e.target).is(e.currentTarget) || $(e.target).hasClass("close")) {
      PopupDisplay.hide()
    }
  })
})
