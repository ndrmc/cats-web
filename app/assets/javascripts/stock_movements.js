// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
    function get_stock_movement_for_edit(receipt_id)
    {
        
         $.ajax( { url: '/stock_movements/stock_movement_edit/' + receipt_id,cache: false, method: 'GET'})
             .done( function(data) {
            alert(data.grn_no);
        //   var id = document.getElementById("project_select");
        //   var text = id.options[id.selectedIndex].text
         
        //    if ($("#project_select").val()!=""){
        //       document.getElementById("project_code").innerHTML=text
        //    } 
        //     document.getElementById("allocated").innerHTML=data.allocated
        //     document.getElementById("received").innerHTML=data.received
        //     document.getElementById("remaining").innerHTML= data.allocated - data.received
            
             });
    }

$(document).ready(function() {

    $("#edit-sm-dispatch-btn").hide(); 
    $("#save-sm-dispatch-btn").show();     

    $('#add-stock-move-dispatch').on('hidden.bs.modal', function () {
		location.reload();
    });
    
    $(".edit_stock_move_dispatch").on('click', function(e) {
        var dispatchid = $(this).attr("data-sm-dispatchid");

        $("#edit-sm-dispatch-btn").attr("data-sm-dispatchid", dispatchid);
        $("#save-sm-dispatch-btn").hide();
        $("#edit-sm-dispatch-btn").show(); 
        $.ajax({
            url:'/stock_movements/get_dispatch',
            type:'GET',
            dataType:'json',
            data:{
                stock_movement: {
                    dispatch_id: dispatchid
                }	            
            },
            before: function() {
                $('#add-stock-move-dispatch .spinner').show(); 
                $('#add-stock-move-dispatch .spinner').attr('style', 'color:#ff0').html('Loading...'); 
            },
            success:function(data){
                $('#gin').val(data[0]); 
                $('#dispatch_date').val(data[1]);
                $('#amount').val(data[2]);
                $('#driver_name').val(data[3]);
                $('#plate_no').val(data[5]);
                $('#plate_no_trailer').val(data[5]);
                $('#store_keeper').val(data[6]);
                
                //remove selected one
                $('option:selected', 'select[name="unit_of_measure"]').removeAttr('selected');
                //Using the text
                $('select[name="unit_of_measure"]').find('option:contains("' + data[7] + '")').attr("selected",true);

                //remove selected one
                $('option:selected', 'select[name="transporter"]').removeAttr('selected');
                //Using the text
                $('select[name="transporter"]').find('option:contains("' + data[9] + '")').attr("selected",true);
            },
            error:function(data){
                $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: Stock movement dispatch was unsuccessful.");
            }
        });       
    });

    $('#edit-sm-dispatch-btn').on('click', function (e) {
        e.preventDefault();

        var smid = $(this).attr("data-smid");
        var dispatchid = $(this).attr("data-sm-dispatchid");
        var gin = $('#gin').val(); 
        var dispatch_date = $('#dispatch_date').val();
        var amount = $('#amount').val();
        var unit_of_measure = $('#unit_of_measure').val();
        var transporter = $('#transporter').val();
        var driver_name = $('#driver_name').val();
        var plate_no = $('#plate_no').val();
        var plate_no_trailer = $('#plate_no_trailer').val();
        var store_keeper = $('#store_keeper').val();
        
        if (dispatchid!='' && dispatchid!=null && gin!='' && gin!=null && dispatch_date!='' && dispatch_date!=null && amount!='' && amount!=null && unit_of_measure!='' && unit_of_measure!=null && transporter!='' && transporter!=null && driver_name!='' && driver_name!=null && plate_no!='' && plate_no!=null && store_keeper!='' && store_keeper!=null)
        {
            $.ajax({
                url:'/stock_movements/stock_movement_dispatch_edit',
                type:'POST',
                dataType:'json',
                data:{
                    stock_movement: {
                        stock_movement_id: smid,
                        dispatch_id: dispatchid,
                        gin: gin,
                        dispatch_date: dispatch_date,
                        amount: amount,
                        unit_of_measure: unit_of_measure,
                        transporter: transporter,
                        driver_name: driver_name,
                        plate_no: plate_no,
                        plate_no_trailer: plate_no_trailer,
                        store_keeper: store_keeper
                    }	            
                },
                before: function() {
                    $('#add-stock-move-dispatch .spinner').show(); 
                    $('#add-stock-move-dispatch .spinner').attr('style', 'color:#ff0').html('Loading...'); 
                },
                success:function(data){
                    if ( data[0] == 'exists' )
                    {
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: GIN already exists. Try using another GIN");		            	
                    }
                    else if (data[0] == 'invalid')
                    {
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: " + data[1]);
                    }
                    else if (data[0] == 'notenough')
                    {
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: " + data[1]);
                    }
                    else if (data[0] == 'failed'){
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: Stock movement dispatch create failed.");
                    }
                    else
                    {
                        $("#add-stock-move-dispatch .close").click();			
                    }		             
                },
                error:function(data){
                    $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: Stock movement dispatch was unsuccessful.");
                }
            });
        }
        else{
            $('#add-stock-move-dispatch .spinner').show(); 
            $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        }
        $('#add-stock-move-dispatch .spinner').delay(3000).fadeOut();
    });


    $('#save-sm-dispatch-btn').on('click', function (e) {
        e.preventDefault();

        var smid = $(this).attr("data-smid");
        var gin = $('#gin').val(); 
        var dispatch_date = $('#dispatch_date').val();
        var amount = $('#amount').val();
        var unit_of_measure = $('#unit_of_measure').val();
        var transporter = $('#transporter').val();
        var driver_name = $('#driver_name').val();
        var plate_no = $('#plate_no').val();
        var plate_no_trailer = $('#plate_no_trailer').val();
        var store_keeper = $('#store_keeper').val();
        
        if (gin!='' && gin!=null && dispatch_date!='' && dispatch_date!=null && amount!='' && amount!=null && unit_of_measure!='' && unit_of_measure!=null && transporter!='' && transporter!=null && driver_name!='' && driver_name!=null && plate_no!='' && plate_no!=null && store_keeper!='' && store_keeper!=null)
        {
            $.ajax({
                url:'/stock_movements/stock_movement_dispatch',
                type:'POST',
                dataType:'json',
                data:{
                    stock_movement: {
                        stock_movement_id: smid,
                        gin: gin,
                        dispatch_date: dispatch_date,
                        amount: amount,
                        unit_of_measure: unit_of_measure,
                        transporter: transporter,
                        driver_name: driver_name,
                        plate_no: plate_no,
                        plate_no_trailer: plate_no_trailer,
                        store_keeper: store_keeper
                    }	            
                },
                before: function() {
                    $('#add-stock-move-dispatch .spinner').show(); 
                    $('#add-stock-move-dispatch .spinner').attr('style', 'color:#ff0').html('Loading...'); 
                },
                success:function(data){
                    if ( data[0] == 'exists' )
                    {
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: GIN already exists. Try using another GIN");		            	
                    }
                    else if (data[0] == 'invalid')
                    {
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: " + data[1]);
                    }
                    else if (data[0] == 'notenough')
                    {
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: " + data[1]);
                    }
                    else if (data[0] == 'failed'){
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: Stock movement dispatch create failed.");
                    }
                    else if (data[0] == 'success')
                    {
                        $("#add-stock-move-dispatch .close").click();
                    }
                    else
                    {
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: Unknown error occurred during dispatch create.");			
                    }	
                    console.log('Message Dump:');
                    console.log(data);	             
                },
                error:function(data){
                    $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: Stock movement dispatch was unsuccessful.");
                    console.log('Message Dump:');
                    console.log(data);
                }
            });
        }
        else{
            $('#add-stock-move-dispatch .spinner').show(); 
            $('#add-stock-move-dispatch .spinner').attr('style', 'color:#f00').html("Error: please fill all fields and try again!");
        }
        $('#add-stock-move-dispatch .spinner').delay(3000).fadeOut();
    });
});