function userRecommendation() {
	document.getElementById("usernameUserRecommendation").value = "James";
	document.getElementById("isUserRecommendation").value = "true";
	document.getElementById("latUserRecommendation").value = lat.toString();
	document.getElementById("lngUserRecommendation").value = lng.toString();
	document.getElementById("isNearbySearch").value = "false";
	document.getElementById("latNearbySearch").value = "0.0";
	document.getElementById("lngNearbySearch").value = "0.0";
}

function nearbySearch() {
	document.getElementById("usernameNearbySearch").value = "James";
	document.getElementById("isUserRecommendation").value = "false";
	document.getElementById("latUserRecommendation").value = "0.0";
	document.getElementById("lngUserRecommendation").value = "0.0";
	document.getElementById("isNearbySearch").value = "true";
	document.getElementById("latNearbySearch").value = lat.toString();
	document.getElementById("lngNearbySearch").value = lng.toString();
}

function addNearbySearchMarkers() {
	for (var i = 0; i < locationsNearbyArr.length / 2; i++) {
		var markerLat = locationsNearbyArr[i * 2];
		var markerLng = locationsNearbyArr[i * 2 + 1];
		var markerPos = { lat:0.0, lng: 0.0 };
		markerPos.lat = markerLat;
		markerPos.lng = markerLng;
		addNearbySearchMarker(markerPos);
	}
}

function addUserRecommendationMarkers() {
	for (var i = 0; i < locationsUserRecommendationArr.length / 2; i++) {
		var markerLat = locationsUserRecommendationArr[i * 2];
		var markerLng = locationsUserRecommendationArr[i * 2 + 1];
		var markerPos = { lat:0.0, lng: 0.0 };
		markerPos.lat = markerLat;
		markerPos.lng = markerLng;
		addUserRecommendationMarker(markerPos);
	}
}
				
function cleanContent(excludedDocument) {
	if (excludedDocument == "userRecommendation") 
	{
		document.getElementById("username").value = "";
		document.getElementById("isNearbySearch").value = "false";
	}
	else if (excludedDocument == "nearbySearch")
	{
		document.getElementById("username").value = "";
		document.getElementById("isUserRecommendation").value = "false";
		document.getElementById("numOfRecommendations").value = "0";
	}
}