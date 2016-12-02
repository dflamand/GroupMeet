

function saveLocations()
{
	var addresses = [];
	var groupid = $("#user_group_ids").val();

	$(".addrInput").each(function (){
		addresses.push($(this).val());
	});

	$.ajax({
		type: "POST",
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/savelocations/" + groupid,
		datatype: "json",
		data: {locations: addresses}
	});
}
