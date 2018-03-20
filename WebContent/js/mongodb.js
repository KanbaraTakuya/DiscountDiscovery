function userRecommendation() {
	document.getElementById("usernameUserRecommendation").value = "james00";
	document.getElementById("isUserRecommendation").value = "true";
	document.getElementById("latUserRecommendation").value = lat.toString();
	document.getElementById("lngUserRecommendation").value = lng.toString();
	document.getElementById("usernameNearby").value = "";
	document.getElementById("isNearby").value = "false";
	document.getElementById("latNearby").value = "0.0";
	document.getElementById("lngNearby").value = "0.0";
	document.getElementById("usernameCategory").value = "";
	document.getElementById("isCategory").value = "false";
	document.getElementById("latCategory").value = "0.0";
	document.getElementById("lngCategory").value = "0.0";
}

function nearbySearch() {
	document.getElementById("usernameUserRecommendation").value = "";
	document.getElementById("isUserRecommendation").value = "false";
	document.getElementById("latUserRecommendation").value = "0.0";
	document.getElementById("lngUserRecommendation").value = "0.0";
	document.getElementById("usernameNearby").value = "james00";
	document.getElementById("isNearby").value = "true";
	document.getElementById("latNearby").value = lat.toString();
	document.getElementById("lngNearby").value = lng.toString();
	document.getElementById("usernameCategory").value = "";
	document.getElementById("isCategory").value = "false";
	document.getElementById("latCategory").value = "0.0";
	document.getElementById("lngCategory").value = "0.0";
}

function categorySearch() {
	document.getElementById("usernameUserRecommendation").value = "";
	document.getElementById("isUserRecommendation").value = "false";
	document.getElementById("latUserRecommendation").value = "0.0";
	document.getElementById("lngUserRecommendation").value = "0.0";
	document.getElementById("usernameNearby").value = "";
	document.getElementById("isNearby").value = "false";
	document.getElementById("latNearby").value = "0.0";
	document.getElementById("lngNearby").value = "0.0";
	document.getElementById("usernameCategory").value = "james00";
	document.getElementById("isCategory").value = "true";
	document.getElementById("latCategory").value = lat.toString();
	document.getElementById("lngCategory").value = lng.toString();
}

function addUserRecommendationMarkers() {
	for (var i = 0; i < namesUserRecommendationArr.length; i++) {
		var markerLat = locationsUserRecommendationArr[i * 2];
		var markerLng = locationsUserRecommendationArr[i * 2 + 1];
		var markerPos = { lat:0.0, lng: 0.0 };
		markerPos.lat = markerLat;
		markerPos.lng = markerLng;
		var name = namesUserRecommendationArr[i];
		var address = addressesUserRecommendationArr[i];
		var category = categoriesUserRecommendationArr[i];
		addUserRecommendationMarker(markerPos, name, address, category);
	}
}

function addNearbySearchMarkers() {
	for (var i = 0; i < namesNearbyArr.length; i++) {
		var markerLat = locationsNearbyArr[i * 2];
		var markerLng = locationsNearbyArr[i * 2 + 1];
		var markerPos = { lat:0.0, lng: 0.0 };
		markerPos.lat = markerLat;
		markerPos.lng = markerLng;
		var name = namesNearbyArr[i];
		var address = addressesNearbyArr[i];
		var category = categoriesNearbyArr[i];
		addNearbySearchMarker(markerPos, name, address, category);
	}
}

function addCategorySearchMarkers() {
	for (var i = 0; i < namesCategoryArr.length; i++) {
		var markerLat = locationsCategoryArr[i * 2];
		var markerLng = locationsCategoryArr[i * 2 + 1];
		var markerPos = { lat:0.0, lng: 0.0 };
		markerPos.lat = markerLat;
		markerPos.lng = markerLng;
		var name = namesCategoryArr[i];
		var address = addressesCategoryArr[i];
		var category = categoriesCategoryArr[i];
		addCategorySearchMarker(markerPos, name, address, category);
	}
}