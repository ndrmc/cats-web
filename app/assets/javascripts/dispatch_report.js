// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).ready(function() {
  $('#dispatch-report-table').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": $('#dispatch-report-table').data('source'),
    "pagingType": "full_numbers",
    "columns": [
      {"data": "location"},
      {"data": "requisition"},
      {"data": "commodity"},
      {"data": "allocated"},
      {"data": "dispatched"},
      {"data": "progress"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables d to learn more about
    // available options.
  });
});