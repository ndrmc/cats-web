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
        	if(data['code'] == 'TR')
            {

                $("#project_code_box").show();
                $("#project_project_code").val('');
                
                $("#project_project_code").removeAttr("readonly");
            }
            else if(data['code'] == '' || data['code'] == null) 
        	{
        		$("#project_code_box").hide();
        	}             
        	else   	    	
        	{
                var res = window.curr_proj_code.split("/");
        		$("#project_code_box").show();
        		$("#project_project_code").val(data['code'] + '/' + res[1] + '/' + res[2]); 
                $("#project_project_code").attr("readonly", "readonly")	  
                window.curr_proj_code = $("#project_project_code").val();      
        	}
        });	
    }
}