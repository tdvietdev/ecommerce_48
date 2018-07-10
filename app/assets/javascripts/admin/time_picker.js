$(function () {
  $('.date').datetimepicker(
      {
        format: 'YYYY-MM-DD HH:mm:ss'
      }
  );
  $('#end_date').datetimepicker({
    useCurrent: false
  });
  $("#start_date").on("dp.change", function (e) {
    $('#end_date').data("DateTimePicker").minDate(e.date);
  });
  $("#end_date").on("dp.change", function (e) {
    $('#start_date').data("DateTimePicker").maxDate(e.date);
  });
});
