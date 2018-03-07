function userRecommendation() {
	document.getElementById("username").value = "James";
	document.getElementById("isUserRecommendation").value = "true";
	document.getElementById("numOfRecommendations").value = "2";
	document.getElementById("isNearbySearch").value = "false";
	document.getElementById("latitude").value = "0.0";
	document.getElementById("longitude").value = "0.0";
}

function nearbySearch() {
	document.getElementById("usernameNearbySearch").value = "James";
	document.getElementById("isUserRecommendation").value = "false";
	document.getElementById("numOfRecommendations").value = "0";
	document.getElementById("isNearbySearch").value = "true";
	document.getElementById("latNearbySearch").value = lat.toString();
	document.getElementById("lngNearbySearch").value = lng.toString();
}

function addNearbySearchMarkers() {
	for (var i = 0; i < nearbyStoresArr.length / 2; i++) {
		var markerLat = nearbyStoresArr[i * 2];
		var markerLng = nearbyStoresArr[i * 2 + 1];
		var markerPos = { lat:0.0, lng: 0.0 };
		markerPos.lat = markerLat;
		markerPos.lng = markerLng;
		addNearbyMarker(markerPos);
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