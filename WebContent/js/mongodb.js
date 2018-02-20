function userRecommendation() {
	document.getElementById("username").value = "James";
	document.getElementById("isUserRecommendation").value = "true";
	document.getElementById("numOfRecommendations").value = "2";
}
				
function cleanContent(excludedDocument) {
	if (excludedDocument != "userRecommendation") {
		document.getElementById("username").value = "";
		document.getElementById("isUserRecommendation").value = "false";
		document.getElementById("numOfRecommendations").value = "0";
	}
}