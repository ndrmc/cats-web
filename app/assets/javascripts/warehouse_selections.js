// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$('#add-warehouse-assignment .spinner').hide();

	$("#region").change(function(){	
		
		var ftid = $(this).attr("data-ftid");
		var query_string = $.param({"region" : $('#region').val()});
		window.location.href = "/en/warehouse_selections/" + ftid + "?" + query_string;
	}); 

    $('#add-warehouse-assignment').on('shown.bs.modal', function (e) {
        e.preventDefault(); 

        var hrd_id = $( e.relatedTarget ).data('hrd-id'); 
        var zone_id = $( e.relatedTarget ).data('zone-id'); 

        $('#modal-title').append(': Region - ' + $("#region option:selected").text());
        $('#add-warehouse-assignment .spinner').show(); 
        $('#add-warehouse-assignment .form-container').hide(); 

        $("#add-warehouse-assignment .form-container").load( '/hrds/new_hrd_item/' + hrd_id + '?zone_id=' + zone_id, function() { 
            $('#add-warehouse-assignment .spinner').hide(); 
            $('#add-warehouse-assignment .form-container').show(); 
        }); 
    });

    $('#add-warehouse-assignment').on('hidden.bs.modal', function () {
		location.reload();
	});

    $('#save-ws-btn').on('click', function (e) {
    	e.preventDefault();

    	var ftid = $(this).attr("data-ftid");
    	var zone = $('#zone').val(); 
        var woreda = $('#woreda').val();
        var hub = $('#hub').val();
        var warehouse = $('#warehouse').val();
        var estimated = $('#estimated_qty').val();
		var query_string = $.param({"region" : $('#region').val()});

        if (ftid!='' && ftid!=null && zone!='' && zone!=null && woreda!='' && woreda!=null && hub!='' && hub!=null && warehouse!='' && warehouse!=null && estimated!='' && estimated!=null)
        {
        	$.ajax({
		        url:'/en/warehouse_selections',
		        type:'POST',
		        dataType:'json',
		        data:{
		        	warehouse_selection: {
		        		framework_tender_id: ftid,
			            location_id: woreda,
			            warehouse_id: warehouse,
			            estimated_qty: estimated
		        	}	            
		        },
		        before: function() {
		        	$('#add-warehouse-assignment .spinner').show(); 
		        	$('#add-warehouse-assignment .spinner').attr('style', 'color:#ff0').html('Loading...'); 
		        },
		        success:function(data){
		        	if ( $('#keep_creating').is(':checked') )
			        {
			        	// $('#add-warehouse-assignment .spinner').hide();
			        	$('#zone').val('');
			        	$('#woreda').val('');
			        	$('#hub').val('');
			        	$('#warehouse').val('');
			        	$('#estimated_qty').val('');
		            	$('#add-warehouse-assignment .spinner').attr('style', 'color:#18a689').html('Warehouse selection was created successfully!');
			        }
				    else
				    {
			        	$("#add-warehouse-assignment .close").click();						
				    }		             
		        },
		        error:function(data){
		            $('#add-warehouse-assignment .spinner').attr('style', 'color:#f00').html("Error: warehouse selection already exits.");
		        }
		    });
        }
        else{
        	$('#add-warehouse-assignment .spinner').show(); 
        	$('#add-warehouse-assignment .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        }
		
    });
});

