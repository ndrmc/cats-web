// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


	
$(document).ready(function() {
	$('#add-transpoter-quote .spinner').hide();
	jQuery(".best_in_place").best_in_place();
   

    $('#add-transpoter-quote').on('hidden.bs.modal', function () {
		location.reload();
	});

    $('#save-ws-btn').on('click', function (e) {
    	e.preventDefault();

    	var ftid = $(this).attr("data-ftid");
    	var zone = $('#zone').val(); 
        var woreda = $('#woreda').val();
        var hub = $('#hub').val();
        var warehouse = $('#warehouse').val();
        var tariff = $('#tariff').val();
		var bid = $('#bid_id').val()
        var transporter = $('#transporter_id').val()

        if (ftid!='' && ftid!=null && zone!='' && zone!=null && woreda!='' && woreda!=null && hub!='' && hub!=null && warehouse!='' && warehouse!=null && tariff!='' && tariff!=null)
        {
        	$.ajax({
		        url:'/en/bid_quotations',
		        type:'POST',
		        dataType:'json',
		        data:{
		        	bid_quotation: {
                        bid_id: bid,
                        transporter_id: transporter,
						bid_quotation_details: {
			            location_id: woreda,
			            warehouse_id: warehouse,
			            tariff_qty: tariff
						}
		        	}	            
		        },
		        before: function() {
		        	$('#add-transpoter-quote .spinner').show(); 
		        	$('#add-transpoter-quote .spinner').attr('style', 'color:#ff0').html('Loading...'); 
		        },
		        success:function(data){
		        	if ( $('#keep_creating').is(':checked') )
			        {
			        	$('#tariff').val('');
		            	$('#add-transpoter-quote .spinner').attr('style', 'color:#18a689').html('Transporter quotation was created susscessfuly!');		            	
			        }
				    else
				    {
			        	$("#add-transpoter-quote .close").click();		
						 toastr.success("Transporter quotation was created susscessfuly."); 				
				    }		             
		        },
		        error:function(data){
				      $('#add-transpoter-quote .spinner').attr('style', 'color:#f00').html("Error: Transporter quote already exits.");
		        }
		    });
        }
        else{
        	$('#add-transpoter-quote .spinner').show(); 
        	$('#add-transpoter-quote .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        }
		$('#add-transpoter-quote .spinner').delay(3000).fadeOut();
    });
});
