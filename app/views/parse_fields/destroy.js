$(".delete-parse-field").bind("ajax:success", function(){
  $(this).closest('tr').fadeOut();
})