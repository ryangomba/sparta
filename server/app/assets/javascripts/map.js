var map;

function initialize_map() {
	var latlng, marker, myOptions, point, points, line;
	latlng = new google.maps.LatLng(43.0, -107.0);
	myOptions = {
		zoom: 15,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById("map"), myOptions);
}

function geocode(address) {
	$('#map').show()
	geocoder = new google.maps.Geocoder()
	geocoder.geocode( { 'address': address}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({
				map: map,
				position: results[0].geometry.location
			});
		}
	});
}
