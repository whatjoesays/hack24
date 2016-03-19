$(function($){
  $(document).on('click', '.swatch .item', function(){
    $(this).toggleClass('active').siblings('.active').removeClass('active');
    $('.your-face').trigger('redraw');
    return false;
  });
  $(document).on('redraw', '.your-face', function(){
    $('.your-face .overlay').empty();
    $('.swatch .item.active').each(function(){
      $($(this).closest('.swatch').data('for')).html( $(this).html() );
    });
  });
});