$(document).on('turbolinks:load page:change', () => {


  $(".show-signup-tab").on("click", (e) => {
    e.preventDefault();
    const $target = $(e.currentTarget);
    const $currentTab = $target.closest('.tab');
    const $tabCard = $currentTab.closest('.tabbed-card');
    const $tabToShow = $tabCard.find('.sign-up-tab');

    $currentTab.removeClass("active");
    $tabToShow.addClass("active");
  });

  $(".show-login-tab").on("click", (e) => {
    e.preventDefault();
    const $target = $(e.currentTarget);
    const $currentTab = $target.closest('.tab');
    const $tabCard = $currentTab.closest('.tabbed-card');
    const $tabToShow = $tabCard.find('.sign-in-tab');

    $currentTab.removeClass("active");
    $tabToShow.addClass("active");
  });

})
