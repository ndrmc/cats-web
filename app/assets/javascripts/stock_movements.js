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
                    if ( $('#keep_creating').is(':checked') )
                    {
                        // $('#add-warehouse-assignment .spinner').hide();
                        // $('#zone').val('');
                        // $('#woreda').val('');
                        // $('#hub').val('');
                        // $('#warehouse').val('');
                        $('#estimated_qty').val('');
                        $('#add-stock-move-dispatch .spinner').attr('style', 'color:#18a689').html('Stock movement dispatch was created successfully!');		            	
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
});