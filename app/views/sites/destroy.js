$(".delete-site").bind("ajax:success", function(){
  $(this).closest('tr').fadeOut();
})