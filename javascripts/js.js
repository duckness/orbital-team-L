$(document).ready(function() {

  //stuff to do on-click
  $('div.accordionButton').click(function() {
    if($(this).next().is(':visible')){
      $(this).next().slideUp('fast');  
    }
    else{
      $(this).next().slideDown('fast');
    }
  });

  //hide divs on page load  
  $("div.accordionContent").hide();
});
