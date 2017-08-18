// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    window.curr_proj_code = $("#project_project_code").val();
});
function get_update_project_code()
{ 	
	var selected_commodity_source_id = $("#project_commodity_source_id").val();

    if(selected_commodity_source_id == '' || selected_commodity_source_id == null)
    {
        $("#project_project_code").val('');
        $("#project_code_box").hide();
    }
    else 
    {        

        $.ajax( { url: '/projects/get_commodity_source_code/' + selected_commodity_source_id,
        	cache: false, method: 'GET'}).done( function(data) 
        {        
            $("#project_project_code").val(data['code'].toString()); 
        	if(data['code'] == '' || data['code'] == null) 
        	{                
        		$("#project_code_box").hide();
        	}             
        	else   	    	
        	{
                $("#project_code_box").show();
        		$("#project_project_code").val(data['code']); 
                $("#project_project_code").attr("readonly", "readonly");
                window.curr_proj_code = $("#project_project_code").val();      
        	}
        });	
            
    }
}