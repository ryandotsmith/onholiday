// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready( function() {
	//User#show _pendtion_requests_queue
	$("#waiting_divs").corners("anti-alias mozilla");
	$("#container").corners(" bottom 15px");
	$(".info_navigation ul").corners("10px top")
	/******************END******************/
	$('a.cluetip').cluetip({	splitTitle: '|',
														showTitle: false
												});

	// Holiday#new

	$("#holiday_begin_time").datepicker();
	$("#holiday_end_time").datepicker();
	
	$("#holiday_type_half").attr("checked", "checked"); 
	$("input[@id=holiday_end_time]").val("")

	$("input[@name='holiday[leave_length]']").change(
		function()
		{
		if ($("input[@id='holiday_leave_length_many']:checked").val())
			$("#end_time").appear();

		else if ($("input[@id='holiday_leave_length_whole']:checked").val())
		{
			$("#end_time").fade();
			$("input[@id=holiday_end_time]").val("")
		}
		else if ($("input[@id='holiday_leave_length_half']:checked").val())
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
	
	$('#holiday_index_table').tablesorter({ widgets: ['zebra'] });
	
	$('#users_index_table').tablesorter({ widgets: ['zebra'] });
})//END Application.js
