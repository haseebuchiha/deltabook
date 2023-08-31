$( document ).ready(function() {

  if ($('#msg').length > 0) {
    $('#msg').scrollTop($('#msg')[0].scrollHeight);
  }

  $('.text-btn').on('click',function() {
      setTimeout(function() {
        $("#msg-form").trigger("reset");
      },100);
      
  });
});
  