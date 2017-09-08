// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$('#new-transport-requisition .spinner').hide();

	$('#new-transport-requisition').on('shown.bs.modal', function (e) {
        
    });

    $('#new-transport-requisition').on('hidden.bs.modal', function () {
		location.reload();
	});

	$("#tr-operation-filter #operation").change(function(){	
		
		var ftid = $(this).attr("data-ftid");
		var query_string = $.param({"operation_id" : $('#tr-operation-filter #operation').val()});
		window.location.href = "/en/transport_requisitions/?" + query_string;
	});

    $('#save-tr-btn').on('click', function (e) {
    	
    	var operation = $('#operation_tr').val();     	
        var region = $('#region_tr').val();
        var bid = $('#bid_tr').val()

        var desc = $('#description_tr').val();
		var query_string = $.param({"region" : $('#region').val()});

        if (operation!='' && operation!=null && region!='' && region!=null)
        {
        	$.ajax({
		        url:'/en/transport_requisitions',
		        type:'POST',
		        dataType:'json',
		        data:{
		        	transport_requisition: {
		        		operation_id: operation,
			            location_id: region,
			            bid_id: bid,

			            description: desc
		        	}	            
		        },
		        beforeSend: function() {
		        	$('#save-tr-btn').prop('disabled', true);
		        	$('#new-transport-requisition .spinner').html('<i class="fa fa-spinner fa-spin" style="font-size:24px"></i>'); 
		        	$('#new-transport-requisition .spinner').fadeIn();
		        },
		        success:function(data){
		        	if ( $('#keep_creating').is(':checked') )
			        {
			        	$('#estimated_qty').val('');
		            	$('#new-transport-requisition .spinner').attr('style', 'color:#18a689').html('Transport Requisition was created successfully!');
		            	$('#new-transport-requisition .spinner').fadeIn();
		            	$('#new-transport-requisition .spinner').delay(3000).fadeOut();
		            	$('#save-tr-btn').prop('disabled', false);		            	
			        }
				    else
				    {
			        	$("#new-transport-requisition .close").click();						
				    }
				            			             
		        },
		        error:function(data){
		            $('#new-transport-requisition .spinner').attr('style', 'color:#f00').html("Error: No approved requisition was found under the selected operation to create Transport Requisition.");
		            $('#new-transport-requisition .spinner').fadeIn();
		            $('#new-transport-requisition .spinner').delay(3000).fadeOut();
		            $('#save-tr-btn').prop('disabled', false);
		        }
		    });
        }
        else{        	 
        	$('#new-transport-requisition .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        	$('#new-transport-requisition .spinner').fadeIn();
        	$('#new-transport-requisition .spinner').delay(3000).fadeOut();
        }		
    });


    $('#new-to-for-exceptions .spinner').hide();

    $('#new-to-for-exceptions').on('shown.bs.modal', function (e) {
    });

    $('#new-to-for-exceptions').on('hidden.bs.modal', function () {
		location.reload();
	});

	$('.create_to_btn').on('click', function () {
		var tr_id = $(this).data('tr');
		var woreda_id = $(this).data('woreda');
		$('#woreda-to').val($(this).data('woreda-name'));
		$('#save-to-btn').data('tr_id', tr_id);
		$('#save-to-btn').data('woreda', woreda_id);
		$.ajax({
	        url:'/en/transport_requisitions/get_fdps_list',
	        type:'GET',
	        dataType:'json',
	        data:{
	        	id: tr_id,
	            location_id: woreda_id	            
	        },
	        beforeSend: function() {
	        	
	        },
	        success:function(data){
	        	var fdps_list = '';
	        	for (var i=0; i < data.length; i++)
        		{
        			fdps_list += data[i]['name'] + ', ';
        		}   
        		$('#fdps_list').html(fdps_list);  			             
	        },
	        error:function(data){
	            $('#fdps_list').html("No fdps found");     
	        }
	    });
	});

	$('#save-to-btn').on('click', function (e) {
    	
    	var tr = $(this).data('tr_id');     	
        var woreda = $(this).data('woreda');
        var transporter = $('#transporter_to').val()
        var trff = $('#tariff-to').val();

        if (transporter!='' && transporter!=null && trff!='' && trff!=null)
        {
        	$.ajax({
		        url:'/en/transport_requisitions/create_to_for_exceptions',
		        type:'POST',
		        dataType:'json',
		        data:{
		        	transport_requisition: {
		        		tr_id: tr,
			            location_id: woreda,
			            transporter_id: transporter,
			            tariff: trff
		        	}	            
		        },
		        beforeSend: function() {
		        	$('#save-to-btn').prop('disabled', true);
		        	$('#new-to-for-exceptions .spinner').html('<i class="fa fa-spinner fa-spin" style="font-size:24px"></i>'); 
		        	$('#new-to-for-exceptions .spinner').fadeIn();
		        },
		        success:function(data){
		        	if ( $('#keep_creating').is(':checked') )
			        {
			        	$('#estimated_qty').val('');
		            	$('#new-to-for-exceptions .spinner').attr('style', 'color:#18a689').html('Transport Order was created successfully!');
		            	$('#new-to-for-exceptions .spinner').fadeIn();
		            	$('#new-to-for-exceptions .spinner').delay(3000).fadeOut();
		            	$('#save-to-btn').prop('disabled', false);		            	
			        }
				    else
				    {
			        	$("#new-to-for-exceptions .close").click();						
				    }
				            			             
		        },
		        error:function(data){
		            $('#new-to-for-exceptions .spinner').attr('style', 'color:#f00').html("Error: Create TO for exception failed!");
		            $('#new-to-for-exceptions .spinner').fadeIn();
		            $('#new-to-for-exceptions .spinner').delay(3000).fadeOut();
		            $('#save-to-btn').prop('disabled', false);
		        }
		    });
        }
        else{        	 
        	$('#new-to-for-exceptions .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        	$('#new-to-for-exceptions .spinner').fadeIn();
        	$('#new-to-for-exceptions .spinner').delay(3000).fadeOut();
        }		
    });

}); 