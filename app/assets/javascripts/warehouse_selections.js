// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$("#region").change(function(){	
		
		var ftid = $(this).attr("data-ftid");
		var query_string = $.param({"region" : $('#region').val()});
		window.location.href = "/en/warehouse_selections/" + ftid + "?" + query_string;
	}); 

      var observer_dom_id = $('#warehouse').attr('id');
      var observed_dom_id = $('#warehouse').data('option-observed');
      var url_mask = $('#warehouse').data('option-url');
      var key_method = $('#warehouse').data('option-key-method');
      var value_method = $('#warehouse').data('option-value-method');
      // var prompt = $(this).has('option[value=]').size() ? $(this).find('option[value=]') : 
      //               $('<option value=\"\">').text('Select a specialization');
      var prompt = $('<option value=\"\">').text('Select a warehouse');
      var regexp = /:[0-9a-zA-Z_]+:/g;
      var observer = $('select#' + observer_dom_id);
      var observed = $('#' + observed_dom_id);
      observer.empty().append(prompt);
      if (observed.val()) {
        //url = url_mask.replace(regexp, observed.val());
        url = "/warehouses/" + observed.val() + ".json";
        $.getJSON(url, function (data) {
          $.each(data, function (i, object) {
            <% if( params[:warehouse].present? ) %>
              if(object[key_method] == <%= params[:warehouse] %> )
              {
                observer.append($('<option>').attr('value', object[key_method]).attr('selected', 'selected')
                  .text(object[value_method]));
              }
              else
              {
                observer.append($('<option>').attr('value', object[key_method]).text(object[value_method]));
              }
            <% else %>
              observer.append($('<option>').attr('value', object[key_method]).text(object[value_method]));
            <% end %>
            observer.removeAttr('disabled');
          });
        });
      }

      cascadeLocation();

    $('#add-warehouse-assignment').on('shown.bs.modal', function (e) {
        e.preventDefault(); 

        var hrd_id = $( e.relatedTarget ).data('hrd-id'); 
        var zone_id = $( e.relatedTarget ).data('zone-id'); 

        $('#add-warehouse-assignment .spinner').show(); 
        $('#add-warehouse-assignment .form-container').hide(); 

        $("#add-warehouse-assignment .form-container").load( '/hrds/new_hrd_item/' + hrd_id + '?zone_id=' + zone_id, function() { 
            $('#add-warehouse-assignment .spinner').hide(); 
            $('#add-warehouse-assignment .form-container').show(); 
        }); 
    });
});

function updateTable(region){
    // var valve = $("#region").val();
    var query_string = $.param({"region" : region});	 
    //var ajax_source = "/en/warehouse_selections/get_by_region?" + query_string;
        
    $.ajax({
            type: 'GET',
            url: "/en/warehouse_selections/get_by_region?" + query_string,
            contentType: 'application/json',
            dataType: 'json',
            success: function(response) {
            		alert(response);
                    $('#results').html('<table id="table-output" class="display" cellspacing="0" width="100%"></table>');
 
                    //													table_config.columns = response.columns;
 
                    var table = $("#ws_datatable").DataTable();
                    table.clear();
                    table.rows.add(response.data);
                    table.draw();
 
                }
        });
    // load data using api
    // table.ajax.url(ajax_source).load();
};

function cascadeLocation()
{
	alert();
	var observer_dom_id = $('#woreda').attr('id');
	var observed_dom_id = $('#woreda').data('option-observed');
	var url_mask = $('#woreda').data('option-url');
	var key_method = $('#woreda').data('option-key-method');
	var value_method = $('#woreda').data('option-value-method');
	// var prompt = $(this).has('option[value=]').size() ? $(this).find('option[value=]') : 
	//               $('<option value=\"\">').text('Select a specialization');
	var prompt = $('<option value=\"\">').text('Select a woreda');
	var regexp = /:[0-9a-zA-Z_]+:/g;
	var observer = $('select#' + observer_dom_id);
	var observed = $('#' + observed_dom_id);
	observer.empty().append(prompt);
	if (observed.val()) {
	//url = url_mask.replace(regexp, observed.val());
	url = "/locations/" + observed.val() + "/children";
	$.getJSON(url, function (data) {
	  $.each(data, function (i, object) {
	    <% if( params[:woreda].present? ) %>
	      if(object[key_method] == <%= params[:woreda] %> )
	      {
	        observer.append($('<option>').attr('value', object[key_method]).attr('selected', 'selected')
	          .text(object[value_method]));
	      }
	      else
	      {
	        observer.append($('<option>').attr('value', object[key_method]).text(object[value_method]));
	      }
	    <% else %>
	      observer.append($('<option>').attr('value', object[key_method]).text(object[value_method]));
	    <% end %>
	    observer.removeAttr('disabled');
	  });
	});
	}
}