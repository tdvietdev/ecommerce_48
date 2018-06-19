$(document).ready(function () {
  if ($(".ckeditor").length > 0) {
    var data = $(".ckeditor");
    $.each(data, function (i) {
      CKEDITOR.replace(data[i].id)
    });
  }
});
