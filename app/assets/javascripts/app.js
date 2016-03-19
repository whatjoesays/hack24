$(function($){
  $(document).on('click', '.swatch .item', function(){
    $(this).toggleClass('active').siblings('.active').removeClass('active');
    $(this).closest('li').removeClass('active');
    $('.your-face').trigger('redraw');
    return false;
  });
  $(document).on('redraw', '.your-face', function(){
    $('.your-face .overlay').empty();
    $('.swatch .item.active').each(function(){
      var forVal = $(this).closest('.swatch').data('for');
      $(forVal).html( $(this).html() );
      $('input[name="choice['+forVal.split('-')[1]+']"]').val($(this).index('.item'));
    });
  });

  $(document).on('click', '.swoptions > li > a', function(){
    $(this).parent().toggleClass('active');
    return false;
  });
});