

function saveLocations()
{
	var addresses = [];
	var transports = [];
	var groupid = $("#user_group_ids").val();

	$(".addrInput").each(function (){
		addresses.push($(this).val());
	});

	$(".transport-options").each(function(){
		$(this).children().each(function(){
			if ($(this).attr("active") == 1)
			{
				transports.push($(this).attr("class"));
			}
		});
	});

	addressInfo = [addresses, transports];

	$.ajax({
		type: "POST",
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/savelocations/" + groupid,
		datatype: "json",
		data: {locations: addressInfo}
	});
}

function loadLocations()
{
	var addresses = [];
	var groupid = $("#user_group_ids").val();

	$.ajax({
		type: "GET",
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/loadlocations/" + groupid,
		datatype: "json",
		success: function (locations){
			increaseAddrInput(locations.length);
			fillAddresses(locations);
		},
	});
}

function increaseAddrInput(count)
{
	while (addrCount < count)
	{
		addAddressHTML();
	}
}

function fillAddresses(locations)
{
	var inputs = $('.addrInput');
	console.log(inputs);

	for (var i = 0; i < locations.length; i++)
	{
		inputs[i].value = (locations[i].address);
	}
}





