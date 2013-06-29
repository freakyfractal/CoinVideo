
// Getting Started (UI Dialog) 
$(function() {
	
	dialogGettingStarted();
	dialogChat();
	
	// Add icons to "Log In" buttons..
	$('.ui-dialog').
		find('button:contains("Log In")').button({
		icons: {
			primary: 'ui-icon-locked'
		}
	});
	
	$('#moreInfoLink').click(function() {
		dialogMoreInfo();
	});
	
	$('#reloadFrame').click(function() {
		$('#myFrame').attr('src', $('#myFrame').attr('src'));
	});
	
	$('#closeChat').click(function() {
		//$('#dialogChat').hide();
		//$('#closeChat').hide();
		$('#dialogChat').dialog('close');
	});
	
	$('#linkInfoMap').click(function() {
		dialogInfoMap();
	});
	
});

var dialogGettingStarted = function() {
	var posX = $(this).outerWidth();
	var posY = $(document).scrollTop();
	$('#dialogGettingStarted').dialog({	
		title: "Getting Started",
		width: 450,
		height: 320,
		position: [posX - 500, posY + 105]
	});
};

var dialogChat = function() {
	var posX = $(this).outerWidth();
	var posY = $(document).scrollTop();
	$('#dialogChat').dialog({	
		title: "Live Chat",
		width: 700,
		height: 510,
		dialogClass: 'no-titlebar',
		draggable: false,
		position: [80, posY + 107]
	}).parent().draggable();

};

var dialogMoreInfo = function() {
	$( "#dialogMoreInfo" ).dialog({
		title: "Get More FREE Bitcoins!",
		width: 400,
		height: 310,
		modal: true,
		resizable: false,
		draggable: false,
		buttons: [
			{
				text: 'Close',
				click: function() { $(this).dialog('close'); }
			}
		]
	});
};

var dialogInfoMap = function() {
	$('#dialogInfoMap').dialog({
		width: $(window).width() - 20,
		height: $(window).height() - 20,
		resizable: false,
		draggable: false,
		//modal: true,
		dialogClass: 'info-map'
	});
	$('.ui-widget-overlay').click(function() { $('#dialogInfoMap').dialog('close'); });
	$('.info-map').click(function() { $('#dialogInfoMap').dialog('close'); });
};