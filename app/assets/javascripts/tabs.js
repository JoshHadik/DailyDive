$(document).on('turbolinks:load page:change', () => {

  $(".tabbed-card").on("click", ".show-signup-tab", (e) => {
    e.preventDefault();
    const $target = $(e.currentTarget);
    const $currentTab = $target.closest('.tab');
    const $tabCard = $currentTab.closest('.tabbed-card');
    const $tabToShow = $tabCard.find('.signup-tab');

    $currentTab.removeClass("active");
    $tabToShow.addClass("active");
  });

  $(".tabbed-card").on("click", ".show-login-tab", (e) => {
    e.preventDefault();
    const $target = $(e.currentTarget);
    const $currentTab = $target.closest('.tab');
    const $tabCard = $currentTab.closest('.tabbed-card');
    const $tabToShow = $tabCard.find('.login-tab');

    $currentTab.removeClass("active");
    $tabToShow.addClass("active");
  });

  $("body").on("click", ".tabbed-card [data-action=change-tab]", (e) => {
    console.log("HERE")
    e.preventDefault();
    const $target = $(e.target);
    const tabReference = $target.data("tab-reference");
    const $card = $target.closest('.card');
    const $activeTab = $card.find('.tab.active');
    const $tabToShow = $card.find(`.tab.${tabReference}`);

    $activeTab.removeClass("active");
    $tabToShow.addClass("active");
  });

})
