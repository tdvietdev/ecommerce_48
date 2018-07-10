function myFunction(id) {
    var quantity = $("#update_item" + id + " > .cart_quantity > input").val();
    if (quantity <= 0 ) $("#update_item" + id + " > .cart_quantity > input").val(1);
  $.ajax({
      url:"/carts/update_item",
      type:'post',
      beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      data:$('#update_item'+id).serialize(),
  })
}
