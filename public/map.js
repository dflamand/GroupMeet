var map;
var addressPoints;
var markers;
var bounds;

//Note: this gets called from a callback on the script include in the html!
//Although, probably a better way to do it...
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: 49.277469, lng: -122.914338},
		zoom: 13
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
	
	console.log("asuh dudes");
	var addr1 = $('#addr1').val();
	var addr2 = $('#addr2').val();
	
	addAddress(addr1);
	addAddress(addr2);
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
		if(addressPoints.length >= 2) {
			calculateMidpoint();
		}
	}
}

function calculateMidpoint() {
	console.log("calculating middle...");
	console.log(addressPoints);
	
	console.log(addressPoints[1].lat);
	
	var lat = (addressPoints[1].lat + addressPoints[0].lat) / 2;
	var lng = (addressPoints[1].lng + addressPoints[0].lng) / 2;
	
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
function addPointToMap(addr) {
	if(addr != null) { //don't really need to check for null, as this only gets called on success of ajax function
		var infoWindow = new google.maps.InfoWindow({
			  content: buildContentString('Calculated Location', addr.formatted_address)
			});
			
		var marker = new google.maps.Marker({
			position: addr.geometry.location,
			map: map,
			title: addr.formatted_address,
			icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png'
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


