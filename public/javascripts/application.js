// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready( function() {

	//User#show _pendtion_requests_queue
	$("#waiting_divs").corners("5px");
	$("#container").corners("15px");
	$(".info_navigation ul").corners("10px top")
	/******************END******************/

	// Holiday#new

	$("#holiday_begin_time").datepicker();
	$("#holiday_end_time").datepicker();
	
	$("#length_opt_half").attr("checked", "checked"); 
	$("input[@id=holiday_end_time]").val("")

	$("input[@name='length_opt']").change(
		function()
		{
		if ($("input[@id='length_opt_many']:checked").val())
			$("#end_time").appear();
		else if ($("input[@id='length_opt_whole']:checked").val())
		{
			$("#end_time").fade();
			$("input[@id=holiday_end_time]").val("")
		}
		else if ($("input[@id='length_opt_half']:checked").val())
		{
			$("#end_time").fade();
			$("input[@id=holiday_end_time]").val("")			
		}
		$(this).blur();
		});		
		/******************END******************/
	
	//User#show
	$('#holiday_history_table').tablesorter(
		{ widthFixed: true, widgets: ['zebra']}
	);
	
	$('#holiday_index_table').tablesorter(
		{ widgets: ['zebra'] }
	);

})//END Application.js
