

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

	$.ajax({
		type: "POST",
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/savelocations/" + groupid,
		datatype: "json",
		data: {address: addresses, modes: transports}
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
	$(".address").each(function(i){
		$(this).children(".input-group").children(".addrInput").val(setAddress(locations[i].address));

		console.log($(this).children(".input-group").children(".addrInput"));

		setModes($(this).children(".transport-options").children(), locations[i].tMode);
	});
}

function setAddress(str)
{
	return str;
}

function setModes(set, type)
{

	set.each(function(){
		if ($(this).attr("class") == type)
		{
			$(this).attr("active", "1");
			$(this).css("color", "rgb(66,134,244)");
		}
		else
		{
			$(this).attr("active", "0");
			$(this).css("color", "black");
		}
	});
}





