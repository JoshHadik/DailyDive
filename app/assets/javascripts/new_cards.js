$(document).on('turbolinks:load page:change', () => {
  if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
    $('body').addClass('mobile')
   // some code..
  }
  if ($('body').hasClass('mobile')) {
    $('.card').css({ 'min-height': window.innerHeight })
  }
})
