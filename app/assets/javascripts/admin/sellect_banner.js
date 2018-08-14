var key = $('#search').val();
var $list_products = $('#list_product');
$("#btn-search").click(function() {
  $list_products.empty();
  var quantity = load_product(key, 1, $list_products);
  console.log(quantity);
  if (quantity > 6) {
    $("#load_product").show();
  }
});
$("#load_product").click(function() {
  $page = $("#current_page");
  page = parseInt($page.val());
  quantity = load_product(key, page, $list_products);
  console.log(quantity);
  if (quantity > 6) {
    $("#load_product").show();
    $page.val(page + 1)
  }else {
    $("#load_product").hide();
  }
});

function load_product(key, page, list_products) {
  var quantity = 0;
  $.ajax({
    url:'/admin/products.json?search='+key+'&page='+page,
    type:'get',
    async: false,
    beforeSend: function(xhr) {
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    },success : function(result) {
      for (product of result) {
        list_products.append($('<input type="radio" name="product_id" value="' +
          product.id + '"onclick="radioClick(this);">' +
          product.name + '</input><br />'));
      }
      quantity = result.length
    }
  })
  return quantity;
}

function radioClick(this_radio) {
  var product_id = this_radio.value;
  console.log(product_id);
  $.ajax({
    url:'/admin/products/'+product_id+'/info',
    type:'get',
    async: true,
    beforeSend: function(xhr) {
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    },success : function(result) {
      console.log(result.link)
      $('#banner_title').val(result.name + result.price)
      $('#banner_link').val(result.link);
    }
  })
}
