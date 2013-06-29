var User = {};

$.ajax({
	url: "/users",
	async: false,
	dataType: 'json',
	success: function(data) {
		User = data;
	}
});

setInterval(function() {
	$.ajax({
		url: "/users",
		async: false,
		dataType: 'json',
		success: function(data) {
			User = data;
			
			$('#displayBalance').fadeOut('slow', function() {
				$('#displayBalance').empty();
				$('<a/>', {
					'class': 'display-balance',
					html: User.Delayed
				}).appendTo('#displayBalance');
				$('#displayBalance').fadeIn('slow', function() {
					// success!!
				});
			});
		}
	});
}, 39*1000);

/* JSON object accessible here */ 
$(function() {
	$("#displayBalance").click(function() {
		
		detailsDialog();

	});

	$('<a/>', {
		'class': 'display-balance',
		html: User.Delayed
	}).appendTo('#displayBalance');
	
});


$(function() {
	$( "#walletDialog" ).dialog({	
		title: "Setup: Bitcoin Wallet",
		width: 500,
		height: 230,
		modal: true,
		resizable: false,
		draggable: false,
		dialogClass: 'no-close',
		buttons: [
			{
				text: 'Save',
				click: function() {
					$("#walletForm").submit();
				}
			}
		]
	});
});
/*
var withdrawDialog = function() {
	$("#dialog").dialog().fadeOut('slow', function() {
		$("#dialog").dialog('close');

		$( "#withdrawDialog" ).dialog({
			title: "Payments",
			width: 500,
			height: 230,
			modal: true,
			resizable: false,
			draggable: false,
			buttons: [
				{
					text: 'Cancel',
					click: function() {
						$(this).dialog().fadeOut('slow', function() {
							$(this).dialog('close');
							detailsDialog();
						});
					}
				},
				{
					text: 'Pay me!',
					click: function() {
						$("#paymentForm").submit();
					}
				}
			]
		});
		
	});
};
*/
var detailsDialog = function() {
	$( "#dialog" ).dialog({
		title: "Account Details",
		width: 400,
		height: 310,
		modal: true,
		resizable: false,
		draggable: false,
		buttons: [
			{
				text: 'Withdraw',
				click: function() {
					//withdrawDialog();
					$("#withdrawForm").submit();
				}
			},
			{
				text: 'Close',
				click: function() { $(this).dialog('close'); }
			}
		]
	});
};

$(function() {
	$("#changeWalletLink").click(function() {
		//event.preventDefault();
		//alert("clicked");
		changeWalletDialog();
	});
});
var changeWalletDialog = function() {
	$( "#changeWalletDialog" ).dialog({	
		title: "Payment Address",
		width: 500,
		height: 230,
		modal: true,
		resizable: false,
		draggable: false,
		dialogClass: 'no-close',
		buttons: [
			{
				text: 'Cancel',
				click: function() { $(this).dialog('close'); }
			},
			{
				text: 'Save',
				click: function() {
					$("#changeWalletForm").submit();
				}
			}
		]
	});
};
