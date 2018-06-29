$(".star").click(function () {
  score = this.value
  $.ajax({
    url: '/rates',
    type: 'post',
    data: {
      authenticity_token: $('[name="csrf-token"]')[0].content,
      rate:
        {
          product_id: $("#product_id").val(),
          user_id: $("#user_id").val(),
          score: score
        }
    },
  });
});
