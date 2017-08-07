// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function get_update_project_code()
{    
	var curr_proj_code = $("#project_project_code").val();
	var res = curr_proj_code.split("/");
	var selected_commodity_source_id = $("#project_commodity_source_id").val();
    $.ajax( { url: '/projects/get_commodity_source_code/' + selected_commodity_source_id,
    	cache: false, method: 'GET'}).done( function(data) 
    {        
    	if(data['code'] == 'TR') 
    	{
    		$("#project_code_box").hide();
    	}
    	else   	    	
    	{
    		$("#project_code_box").show();
    		$("#project_project_code").val(data['code'] + '/' + res[1] + '/' + res[2]); 	        
    	}
    });	
}