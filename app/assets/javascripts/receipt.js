 $(function () {
// commodity category change
 $('#commodity-category-select').change(function () {
        var val = $(this).val();

        if (val === '') {
          return;
        }

        $("#commodity-select > option").addClass('hidden');
        $("#commodity-select > option.cc-" + val).removeClass('hidden');

        $("#commodity-select > option:first").removeClass('hidden');

      });//end
   
//---------------add receipt line

 $("#add-receipt-line").click(function (e) {
        e.preventDefault();

        var $this = $(this);

        var $receiptLineForm = $this.closest('tr');

        var valid = true;

        $receiptLineForm.find(':input').each(function () {
          $(this).parsley().validate();
          valid = $(this).parsley().isValid() && valid;
        });

        if (!valid) {
          return;
        }

        current_project_id = $("#project_select").val();
        current_hub_id = $("#hub_select").val();

        var $newRow = $receiptLineForm.clone();

        $newRow.find('td').last().html(REMOVE_RECEIPTLINE_BTN);

        $newRow.find(':input').attr('readonly', true).removeAttr('id');

        $newRow.addClass('receipt-line');

        $newRow.insertBefore($receiptLineForm);

        $receiptLineForm.find(':input').val('');

        
      });
//---------------end receipt line


 $('#submit-receipt-and-new').click(function (e) {

        if ($('.receipt-line').length === 0) {
          toastr.error("You are required to add at least one commodity.");
alert("");
          e.preventDefault();
          return;
        }
       
       
        setTimeout(function() {
     get_received_qty(current_project_id,current_hub_id);
   }, 3000);

        
      });


      $('#submit-receipt').click(function (e) {

        if ($('.receipt-line').length === 0) {
          toastr.error("You are required to add at least one commodity.");

          e.preventDefault();
          return;
        }
       
       
        setTimeout(function() {
     get_received_qty(current_project_id,current_hub_id);
   }, 3000);

        
      }); 


    $('#project_select').change(function(){
 project_id = $(this).val();
 hub_id = $('#hub_select').val();
 get_received_qty(project_id,hub_id);
 var element = document.getElementById("prject_code_status");
 element.style.display = 'block';
});


  $('#receiptLinesTableBody').on('click', '.remove-receipt-line', function (e) {
        $(e.target).closest('tr').fadeOut('slow', function () {
          $(this).remove();
        });
      });


 }); // main function end


        function get_received_qty(id,hub_id)
    {
        
        $.ajax( { url: '/receipts/getProjectCodeStatus/' + id + '?hub_id=' + hub_id,cache: false, method: 'GET'})
            .done( function(data) {
            
          var id = document.getElementById("project_select");
          var text = id.options[id.selectedIndex].text
         
           if ($("#project_select").val()!=""){
              document.getElementById("project_code").innerHTML=text
           } 
            document.getElementById("allocated").innerHTML=data.allocated
            document.getElementById("received").innerHTML=data.received
            document.getElementById("remaining").innerHTML= data.allocated - data.received
            
            });
    }







    

     


  
     