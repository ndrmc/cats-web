// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$("#region").change(function(){
		updateTable($('#region').val());
	    alert("The text has been changed.");
	}); 
});

function updateTable(region){
    // var valve = $("#region").val();
    var query_string = $.param({"region" : region})
    var ajax_source = "/en/warehouse_selections/get_by_region?" + query_string
    var table = $("#ws_datatable").DataTable(); // get api instance
    // load data using api
    table.ajax.url(ajax_source).load();
};