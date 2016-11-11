var map;
var addressPoints;
var markers;
var bounds;

var addrCount = 2;
var addrLength = 0;
var addrMinimum = 2;

//Note: this gets called from a callback on the script include in the html!
//Although, probably a better way to do it...
function addAddressHTML() {
	console.log("asuh dudes");

	addrCount++;
	var addrStr = 'addr' + addrCount;
	var newHTML = 'Address ' + addrCount + ': <input id="' + addrStr + '" type="text" class="addrInput" name="'+ addrStr +'"><br>'

	$( "#addressList" ).append(newHTML);
}

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: 49.277469, lng: -122.914338},
		zoom: 13,
		mapTypeControl: false,
		streetViewControl: false,
  		mapTypeId: google.maps.MapTypeId.ROADMAP
	});
}

function clearMarkers() {
	if(markers != null || markers && undefined) {
		for(var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
	}
}

function calculateAddr() {
	addressPoints = [];
	bounds = new google.maps.LatLngBounds();

	clearMarkers();
	markers = [];
	addrLength = 0;

	//gets expected count of addresses, so not calculating >1 time
	$(".addrInput").each(function() {
		console.log($(this));
		if($(this) != null && $(this).val().length > 0)
			addrLength += 1;
	});

	$(".addrInput").each(function() {
		var addr = $(this).val();
		addAddress(addr);
	});

}

function addAddress(addr) {
	if(addr != null && addr.length > 0) {
		console.log(addr);
		//load the data
		$.getJSON( {
			url  : 'https://maps.googleapis.com/maps/api/geocode/json',
			data : {
				componentRestrictions: {
					country: 'CA'
				  },
				sensor  : false,
				address : addr
			},
			success : function( data, textStatus ) {
				addAddressToArray(data);
			} //should add popup window on error
		} );
	}
}

function addAddressToArray(data) {
	if(data != null) {
		var address = data.results[0].geometry.location;
		addressPoints.push(address);

		if(addressPoints.length == addrLength && addrLength >= addrMinimum) {
			console.log("calculating midpoint...");
			calculateMidpoint();
		}
	}
}

function calculateMidpoint() {

	var lat = 0.0;
	var lng = 0.0;

	console.log("addresspoints len: " + addressPoints.length);

	for(var i = 0; i < addressPoints.length; i++) {
		console.log("adding: lat:" + addressPoints[i].lat + " lng: " + addressPoints[i].lng);
		lat = lat + addressPoints[i].lat;
		lng = lng + addressPoints[i].lng;
	}

	lat = lat / addressPoints.length;
	lng = lng / addressPoints.length;

	var pointStr = lat + "," + lng;
	console.log(pointStr);

	//After calculating midpoint, now need to get its nearest address
	$.getJSON( {
		url  : 'https://maps.googleapis.com/maps/api/geocode/json',
		data : {
			latlng : pointStr
		},
		success : function( data, textStatus ) {
			addPointToMap(data.results[0]);
		} //should add popup window on error
	} );
}

//Adds calculated midpoint to the map, looks for surround locations by keyword
function addPointToMap(addr, isUserLocation) {
	if(addr != null) { //don't really need to check for null, as this only gets called on success of ajax function
		var iconColor = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';
		if(isUserLocation != undefined && isUserLocation == true)
			iconColor = 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png';

		var infoWindow = new google.maps.InfoWindow({
			  content: buildContentString('Calculated Location', addr.formatted_address)
			});

		var marker = new google.maps.Marker({
			position: addr.geometry.location,
			map: map,
			title: addr.formatted_address,
			icon: iconColor
		});

		addMarkerToMap(marker, infoWindow);
		//find them starbucks!
		loadLocationsForMarkerByKeyword('Starbucks', marker.getPosition());
	}
}

function addMarkerToMap(marker, infoWindow) {
	marker.addListener('click', function() {
		if(infoWindow)
		  infoWindow.open(map, marker);
		});

	markers.push(marker);

	var current_bounds = map.getBounds();
	var marker_pos = marker.getPosition();

	bounds.extend(marker.getPosition()); //extend the bounds to include the marker
}

function loadLocationsForMarkerByKeyword(keyword, markerPos) {
	console.log("loading starbs...\n")
	var request = {
		location: markerPos,
		radius: 2000,
		keyword: keyword
	  };

	var service = new google.maps.places.PlacesService(map);
	service.nearbySearch(request, addNearbyLocations);
}

function buildContentString(title, subtitle) {
	var contentString;
	if(title != null) {
		contentString =
			'<div id="content"><h4 id="firstHeading" class="firstHeading">'
			+ title + '</h4>';
	}
	if(subtitle != null) {
		contentString += '<p id="secondHeading" class="secondHeading">'
		+ subtitle + '</p>';
	}
	return contentString;
}

function addNearbyLocations(results, status) {
	if (status == google.maps.places.PlacesServiceStatus.OK) {
		for (var i = 0; i < results.length; i++) {
			var addr = results[i];

			var infoWindow = new google.maps.InfoWindow({
				  content: buildContentString(addr.name, addr.vicinity)
				});

			var marker = new google.maps.Marker({
				position: addr.geometry.location,
				map: map,
				title: addr.formatted_address
			});

			addMarkerToMap(marker, infoWindow);
		}

		//now set bounds to include our calculated locations
		map.fitBounds(bounds);
	}
}


