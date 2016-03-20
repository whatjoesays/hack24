$(function($){
  $(document).on('click', '.swatch .item', function(){
    // make active
    $(this).toggleClass('active').siblings('.active').removeClass('active');

    // redraw all
    $('.your-face').trigger('redraw');

    // apply transition to destination image
    var selOffset = $(this).offset();
    var $forImg = $($(this).closest('.swatch').data('for')).find('img');
    var forOffset = $forImg.offset();
    $forImg.css({
      'transition': 'none',
      'transform': 'translate('+(selOffset.left-forOffset.left)+'px, '+(selOffset.top-forOffset.top)+'px)',
      'width': '50px',
      'height': '50px'
    });

    // hide modal
    $(this).closest('li').removeClass('active');
    return false;
  });

  $(document).on('redraw', '.your-face', function(){
    $('.your-face .overlay').empty();
    $('.swatch .item.active').each(function(){
      var forVal = $(this).closest('.swatch').data('for');
      var $forEl = $(forVal).html( $(this).html() );
      setTimeout(function(){
        $forEl.find('img').css({ 'transition': '', 'transform': '', 'height': '', 'width': '' });
      }, 250);
      $('input[name="choice['+forVal.split('-')[1]+']"]').val($(this).index('.item'));
    });
  });

  $(document).on('click', '.swoptions > li > a', function(){
    $(this).parent().toggleClass('active');
    return false;
  });

  //https://pixlcore.com/demos/webcamjs/demos/combo.html
  $('#snapphoto').on('click', function(){
    Webcam.snap( function(data_uri) {
    // shut down camera, stop capturing
      Webcam.reset();

      $('input[name="our_image"]').val(data_uri);
      //alert(data_uri);
      setTimeout(function(){
        $('form').submit();
      }, 500);


      //
    } );
    return false;
  });
});