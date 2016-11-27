var locationType;
var locationIndex = 5;
var map;

var addressPoints;
var formattedAddrs;

var markers;
var bounds;
var autocompletes = [];

var addrCount = 2;
var addrLength = 0;
var addrMinimum = 2;

var selectedDestination = "";

var directionsService;
var directionsDisplay;

//Document fully loaded
$( document ).ready(function() {
		initMap();
		initAutoComplete();
});

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: 49.277469, lng: -122.914338},
		zoom: 13,
		mapTypeControl: false,
		streetViewControl: false,
  		mapTypeId: google.maps.MapTypeId.ROADMAP
	});

	directionsService = new google.maps.DirectionsService;
	directionsDisplay = new google.maps.DirectionsRenderer;

	directionsDisplay.setMap(map);

	setOptionModal();
}

function initAutoComplete() {
	autocompletes= [];

	$('.addrInput').each(function() {
		addAutoCompleteToInputField($(this));
	});

}

function addAutoCompleteToInputField(input) {
	var options = {
		  componentRestrictions: {country: 'ca'}
	};

	console.log(input);

	var autocomplete = new google.maps.places.Autocomplete(input[0], options);
	google.maps.event.addListener(autocomplete, 'place_changed', function () {
            var place = autocomplete.getPlace();
            $(input).attr('addr', $(input).val());
            $(input).attr('lat', place.geometry.location.lat());
            $(input).attr('lng', place.geometry.location.lng());
        });
	autocompletes.push(autocomplete);
}

function calculateAddr() {
	addressPoints = [];
	formattedAddrs = [];
	bounds = new google.maps.LatLngBounds();

	locationType = "";
	clearMarkers();
	markers = [];
	addrLength = 0;

	loadLocation();

	//gets expected count of addresses, so not calculating >1 time
	$(".addrInput").each(function() {
		if($(this) != null && $(this).val().length > 0) {
			if($(this).siblings().find('.addressCheck').is(":checked"))
				addrLength += 1;
		}
	});

	$(".addrInput").each(function() {
		if($(this) != null && $(this).val().length > 0) {
			if($(this).siblings().find('.addressCheck').is(":checked")){
				var addr = $(this).val();
				console.log(addr);
				console.log($(this));
				console.log($(this).attr('lat'));
				addAddress($(this));
			}
		}
	});
}

function addAddressHTML() {
  addrCount++;
  var addrStr = 'addr' + addrCount;

  var newHTML = '<div class="address"> <div class="address-header">' + 'Address ' + addrCount +'</div> <div class="transport-options"> <a class="carMode"><i class="fa fa-car"></i></a> <a class="transitMode"><i class="fa fa-subway"></i></a> <a class="walkMode"><i class="fa fa-male"></i></a> <a class="bicycleMode"><i class="fa fa-bicycle"></i></a></div>' +
  '<div class="input-group"><span class="input-group-addon"><input class="addressCheck" type="checkbox" name="' + addrStr + '"checked></span><input id="' + addrStr + '" type="text" class="form-control addrInput" name="' + addrStr + '" placeholder="Address ' + addrCount + '"></div>'
  + '<div class="row tripInfo"><div class="tripDuration col-md-6"><span class="glyphicon glyphicon-hourglass" aria-hidden="true"></span><span id="timeText"> 10 Minutes </span> </div> <div class="tripDistance col-md-6"> <span class="glyphicon glyphicon-flag" aria-hidden="true"></span><span id="distanceText"> 10 KM </span></div> </div> </div><hr>';

  $( "#addressList" ).append(newHTML);
  console.log(addrStr);
  addAutoCompleteToInputField($('#' + addrStr));
}


function clearMarkers() {
	if(markers != null || markers && undefined) {
		for(var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
	}
}

function setOptionModal() {
	$('#locList').change(function(){
	  if($('#locList').val() == "Other...") {
			$('#optionModal').addClass("show").removeClass("fade");

	  }
	  else {
			$('#optionModal').addClass("fade").removeClass("show");
	  }
	});

	//Click function to hide modal on 'x' press
	$('#optionModalClose').click(function() {
		$('#optionModal').addClass("fade").removeClass("show");
		$("#locList").val($('#initOption').val()).trigger('change');
	});

	//Add user specified option, re-order so 'Other...' is @ bottom of list
	$('#optionModalSave').click(function() {
		if($('#optionModalInput').val().length > 0) {
			$('#optionModalClose').click(); //hide the modal

			$('#otherOption').remove();

			//Add user option
			$('#locList').append($('<option/>', {
        text : $('#optionModalInput').val(),
    	}).attr('index', locationIndex));
			$("#locList").val($('#optionModalInput').val()).trigger('change');

			//Re add "other" at bottom of list
			$('#locList').append($('<option/>', {
        text : 'Other...',
        id : 'otherOption'
    	}).attr('index', locationIndex += 1).attr('data-toggle', 'modal').attr('data-target', '#optionModal'));

    	//Reset modal val
    	$('#optionModalInput').val('');
		}
	});
}

function loadLocation() {
	if(locationType == undefined || locationType == null)
		locationType = "";
	else
		locationType = $("#locList").val();
}

function addAddress(addr) {
	if(addr != null && addr.length > 0) {

		var location = {};

		var isLastAddr = addr.attr('addr') == addr.val();
		if(isLastAddr && addr.attr('lat') != null && addr.attr('lng') != null) {
			console.log("MOST RECENT");
			location.lat = addr.attr('lat');
			location.lng = addr.attr('lng');
			console.log(location);
			addAddressToArray(location);
		}
		else {
			console.log("NOT most recent");
			var address = addr.val();
			console.log(addr);

			//load the data
			$.getJSON( {
				url  : 'https://maps.googleapis.com/maps/api/geocode/json',
				data : {
					componentRestrictions: { country: 'CA' },
					sensor  : false,
					address : address
				},
				success : function( data, textStatus ) {
					if(data.results.length > 0)
						addAddressToArray(data.results[0].geometry.location);
				} //should add popup window on error
			});
		}
	}
}

function addAddressToArray(addr) {
	if(addr != null) {
		addressPoints.push(addr);

		if(addressPoints.length == addrLength && addrLength >= addrMinimum) {
			calculateMidpoint();
		}
	}
	else {
		console.log("Could not load address for location. Data:");
		console.log(data);
	}
}

function addUserPointsToMap() {
	for(var i = 0; i < addressPoints.length; i++) {
		console.log(addressPoints[i]);
		var lat = addressPoints[i].lat;
		var lng = addressPoints[i].lng;
		var pointStr = lat + "," + lng;

		$.getJSON( {
			url  : 'https://maps.googleapis.com/maps/api/geocode/json',
			data : {
				latlng : pointStr
			},
			success : function( data, textStatus ) {
				addPointToMap(data.results[0], true);
			} //should add popup window on error
		});
	}


}

function calculateMidpoint() {
	console.log("calculating point...");
	addUserPointsToMap();

	var lat = 0.0;
	var lng = 0.0;

	console.log("addresspoints len: " + addressPoints.length);

	for(var i = 0; i < addressPoints.length; i++) {
		console.log("adding: lat:" + addressPoints[i].lat + " lng: " + addressPoints[i].lng);
		lat = lat + parseFloat(addressPoints[i].lat);
		lng = lng + parseFloat(addressPoints[i].lng);
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

		//Build Location popup window
		var infoString;

		if(isUserLocation == undefined || isUserLocation == false)
			infoString = 'Calculated Location';
		else {
			infoString = 'User Location';
			formattedAddrs.push(addr.formatted_address);
		}


		var infoWindow = new google.maps.InfoWindow({
			  content: buildContentString(infoString, addr.formatted_address)
			});

		var marker = new google.maps.Marker({
			position: addr.geometry.location,
			map: map,
			title: addr.formatted_address,
			icon: iconColor
		});

		addMarkerToMap(marker, infoWindow);

		//Only looks up locations if this is not a user provided location
		if(isUserLocation == undefined || isUserLocation == false)
			loadLocationsForMarkerByKeyword(locationType, marker.getPosition());
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
	console.log("loading " + keyword +"...\n")

	var request = {
		location: markerPos,
		radius: 2000,
		keyword: keyword
	  };

	var service = new google.maps.places.PlacesService(map);
	service.nearbySearch(request, addNearbyLocations);
}

function buildContentString(title, subtitle, isDestination) {
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

	if(isDestination != undefined && isDestination == true) {
		contentString += '<button type="button" onclick="setAsDestination(event)" class="btn btn-primary btn-sm destButton">Set as Destination</button>'
	}
	return contentString;
}

function addNearbyLocations(results, status) {
	if (status == google.maps.places.PlacesServiceStatus.OK) {
		for (var i = 0; i < results.length; i++) {
			var addr = results[i];

			var infoWindow = new google.maps.InfoWindow({
				  content: buildContentString(addr.name, addr.vicinity, true)
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

function calculatePathToPoint(startPoint, destPoint) {
  directionsService.route({
    origin: startPoint,
    destination: destPoint,
    travelMode: 'DRIVING'
  }, function(response, status) {
    if (status === 'OK') {
      directionsDisplay.setDirections(response);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
}

function calculateTravelTime(key, startAddr, endAddr) {
	console.log("!!!calculating travel time");
	var service = new google.maps.DistanceMatrixService();
    service.getDistanceMatrix(
      {
        origins: [startAddr],
        destinations: [endAddr],
        travelMode: 'DRIVING',
        unitSystem: google.maps.UnitSystem.METRIC,
        durationInTraffic: true,
        avoidHighways: false,
        avoidTolls: false
      }, function(response, status) {addCalculatedTime(key, response, status)});
}

	function addCalculatedTime(key, response, status) {
		var timeString = response.rows[0].elements[0].duration.text;
		var distanceString = response.rows[0].elements[0].distance.text;

		var index = 0;
		console.log('key is ' + key);
		$(".addrInput").each(function() {
			if($(this) != undefined && $(this).val().length > 0 && $(this).siblings().find('.addressCheck').is(":checked")) {
				if(index == key) {
					$(this).parent().next().find('#timeText').text(' ' + timeString);
					$(this).parent().next().find('#distanceText').text(' ' + distanceString);
					return false;
				}
				else {
					index++;
				}
			}
		});
	}


function setAsDestination(event) {
	console.log("setting as destination...");
	selectedDestination = $(event.target).prev().text();
	$.each( formattedAddrs, function( key, value ) {
		calculateTravelTime(key, value, selectedDestination);
	});
}
