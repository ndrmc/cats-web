$(document).ready(function() {
	$('#print-to .spinner').hide();

    $('#print-to').on('shown.bs.modal', function (e) {
        e.preventDefault(); 
    });

    $('#print-to').on('hidden.bs.modal', function () {
		// location.reload();
	});                                                                                                             

    $('#print-to-btn').on('click', function (e) {
    	e.preventDefault();

    	var toid = $(this).attr("data-toid");
    	var startDate = $('#start_date').val(); 
        var endDate = $('#end_date').val();

        if (toid!='' && toid!=null && startDate!='' && startDate!=null && endDate!='' && endDate!=null)
        {
        	$.ajax({
		        url:'/transport_orders/print_get/',
		        type:'POST',
		        dataType:'json',
		        data:{
		        	transport_order: {
		        		toid: toid,
			            startDate: startDate,
			            endDate: endDate
		        	}	            
		        },
		        before: function() {
		        	$('#print-to .spinner').show(); 
		        	$('#print-to .spinner').attr('style', 'color:#ff0').html('Loading...'); 
		        },
		        success:function(data){
		        		             
		        },
		        error:function(data){
		            
		        }
		    });
        }
        else{
        	$('#print-to .spinner').show(); 
        	$('#print-to .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        }
		$('#print-to .spinner').delay(3000).fadeOut();
    });
});
