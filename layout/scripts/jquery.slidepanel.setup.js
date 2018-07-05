$(document).ready(function() {
	
	// Expand Panel
	$("#slideit").click(function(){
		$("div#socialise").slideDown("slow");
	
	});	
	
	// Collapse Panel
	$("#closeit").click(function(){
		$("div#socialise").slideUp("slow");	
	});		
	
	// Switch buttons from "Open" to "Close" on click
	$(".toggler a").click(function () {
		$(".toggler a").toggle();
	});		
		
});