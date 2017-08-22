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
			            description: desc
		        	}	            
		        },
		        before: function() {
		        	$('#new-transport-requisition .spinner').show(); 
		        	$('#new-transport-requisition .spinner').attr('style', 'color:#ff0').html('Loading...'); 
		        },
		        success:function(data){
		        	if ( $('#keep_creating').is(':checked') )
			        {
			        	$('#estimated_qty').val('');
		            	$('#new-transport-requisition .spinner').attr('style', 'color:#18a689').html('Transport Requisition was created successfully!');	            	
			        }
				    else
				    {
			        	$("#new-transport-requisition .close").click();						
				    }	        			             
		        },
		        error:function(data){
		            $('#new-transport-requisition .spinner').attr('style', 'color:#f00').html("Error: No approved requisition was found under the selected operation to create Transport Requisition.");
		        }
		    });
        }
        else{
        	$('#new-transport-requisition .spinner').show(); 
        	$('#new-transport-requisition .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        }
		$('#new-transport-requisition .spinner').delay(3000).fadeOut();
    });
}); 