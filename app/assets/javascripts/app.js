$(function($){
  // choose a customisation item
  $(document).on('click', '.swatch .item', function(){
    // make active
    $(this).toggleClass('active').siblings('.active').removeClass('active');

    // redraw all
    $('.editor-photo').trigger('redraw');

    // apply transition to destination image
    var selOffset = $(this).offset();
    var $forImg = $($(this).closest('.swatch').data('for')).find('img');
    var forOffset = $forImg.offset();
    $forImg.css({
      'transition': 'none',
      'transform': 'translate('+(selOffset.left-forOffset.left)+'px, '+(selOffset.top-forOffset.top)+'px)',
      'width': '79px',
      'height': 'auto'
    });

    // hide modal
    $(this).closest('li').removeClass('active');
    return false;
  });

  // render all objects over image
  $(document).on('redraw', '.editor-photo', function(){
    $('.editor-photo .editor-overlay').empty();
    $('.controls > li.selected').removeClass('selected');
    var count = $('.swatch .item.active').each(function(){
      $(this).closest('li').addClass('selected');
      var forVal = $(this).closest('.swatch').data('for');
      var $forEl = $(forVal).html( $(this).html() );
      setTimeout(function(){
        $forEl.find('img').css({ 'transition': '', 'transform': '', 'height': '', 'width': '' });
      }, 250);
      $('input[name="choice['+forVal.split('-')[1]+']"]').val($(this).index('.item'));
    }).length;
    $('body').toggleClass('editor--done', count == 4);
  }).trigger('redraw');

  // show options
  $(document).on('click', '.controls > li > a', function(){
    $(this).parent().toggleClass('active');
    return false;
  });

  // webcam submit!
  //https://pixlcore.com/demos/webcamjs/demos/combo.html
  $('#snapphoto').on('click', function(){
    Webcam.snap( function(data_uri) {
      if(typeof data_uri == 'undefined' || data_uri.length == 0){
        alert('Camera not quite ready - try again in a sec!');
      } else {

        $('input[name="our_image"]').val(data_uri);

        // shut down camera, stop capturing
        Webcam.reset();

        //alert(data_uri);
        setTimeout(function(){
          $('form').submit();
        }, 500);

      }
      //
    } );
    return false;
  });

  // hacky overlay removal
  $(document).on('click', 'a[href="#removeoverlay"]', function(){
    $(this).closest('.overlay').fadeOut();
    $('.mask').fadeOut();
    return false;
  });

  // trigger another button (i.e. submit form from outside form)
  $(document).on('click', '.js-trigger-btn', function(){
    $( $(this).attr('href') ).click();
  });
});