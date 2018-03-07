<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <title>Portfolio Item - Start Bootstrap Template</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/portfolio-item.css" rel="stylesheet">

	<%
      double[] userRecommendations = null;
      if ((double[])session.getAttribute("userRecommendations") != null)
        userRecommendations = (double[])session.getAttribute("userRecommendations");
        
      double[] nearbyStores = null;
      if ((double[])session.getAttribute("nearbyStores") != null)
        nearbyStores = (double[])session.getAttribute("nearbyStores");
    %>
  </head>

  <body onload="putNearbySearchMarkers()">
    <input type="hidden" id="isUserRecommendation" name="isUserRecommendation" value="false"/>
    <input type="hidden" id="numOfRecommendations" name="numOfRecommendations" value="0"/>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-info fixed-top">
      <div class="container">
        <a class="navbar-brand" href="index.jsp">DISCOUNTS DISCOVERY</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="aboutus.jsp">About us</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="topdeals.jsp">Top Deals</a>
            </li>
            <li class="nav-item">
              <div class="wrap">
               <form class="search" action="/action_page.php" style="margin:ato;max-width:300px">
                 <input type="text" class="searchTerm" placeholder="What are you looking for?" name="search">
                 <button type="submit" class="searchButton">
                 <i class="fa fa-search"></i>
                 </button>
               </form>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link" href='#' onclick="document.getElementById('id01').style.display='block'">Log In</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

        <!-- Page Content -->
    <div class="container">

      <!-- Portfolio Item Heading -->
      <h1 class="my-4">Page Heading
        <small>Secondary Text</small>
      </h1>

      <!-- Portfolio Item Row -->
      <div class="row">

        <div class="col-md-8">
          <h1>See the best deals on the map!</h1>

          <div id="map" style="width:100%;height:400px;"></div>
              <script>
                // Note: This example requires that you consent to location sharing when
                // prompted by your browser. If you see the error "The Geolocation service
                // failed.", it means you probably did not give permission for the browser to
                // locate you.
                var map;
                var lat = 0.0;
            	var lng = 0.0;
            	var markers = [];
            	var nearbyMarkers = [];
            	
                function initMap() {
                  map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 53.319062, lng: -2.845459},
                    zoom: 6
                  });
                  
                  map.addListener('click', function(event) {
                	  deleteMarkers();
                      addMarker(event.latLng);
                      lat = event.latLng.lat();
                      lng = event.latLng.lng();
                      updateLatAndLng();
                  });

                  // Try HTML5 geolocation.
                  if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function(position) {
                      var pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude

                      };
                      //the position of marker UoM currently
                      var markerPos = {
                        lat: 53.464824,
                        lng: -2.231782
                      }
                      //content of marker
                      var contentString = '<div id="content">'+
    '<div id="siteNotice">'+
    '</div>'+
    '<h1 id="firstHeading" class="firstHeading">The University of Manchester</h1>'+
    '<div id="bodyContent">'+
    '<p><b>The University of Manchester</b> is our home!</p>'+
    '<p>Attribution: Manchester, <a href="http://www.manchester.ac.uk/">'+
    'Website</a> '+
    '</div>'+
    '</div>';
              //marker with a information window
              var infowindow = new google.maps.InfoWindow({
                               content: contentString
                               });

               var marker = new google.maps.Marker({
                            position: markerPos,
                            map: map,
                            title: 'Manchester'
                            });
               
               //when marker is selected, information window appears
               marker.addListener('click', function() {
                                  infowindow.open(map, marker);
                                  });
                      //zoom in map
                      map.setCenter(pos);
                      map.setZoom(12);
                    }, function() {
                      handleLocationError(true, infoWindow, map.getCenter());
                    }
                   );
                  } else {
                    // Browser doesn't support Geolocation
                    handleLocationError(false, infoWindow, map.getCenter());
                  }
                }

                function handleLocationError(browserHasGeolocation, infoWindow, pos) {
                  infoWindow.setPosition(pos);
                  infoWindow.setContent(browserHasGeolocation ?
                                        'Error: The Geolocation service failed.' :
                                        'Error: Your browser doesn\'t support geolocation.');
                  infoWindow.open(map);
                }
              </script>
              <script async defer
              src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAQ5InZv-AH3sMeMTKwWUDJ84Vm5bk9P6M&callback=initMap">
              </script>
              
              
              <form action="DiscountDiscovery" method="post">
                <input type="hidden" id="usernameNearbySearch" name="usernameNearbySearch" value=""/>
                <input type="hidden" id="isNearbySearch" name="isNearbySearch" value="false"/>
    			<input type="hidden" id="latNearbySearch" name="latNearbySearch" value="0.0"/>
    			<input type="hidden" id="lngNearbySearch" name="lngNearbySearch" value="0.0"/>
	  			<input type="submit" value="nearbySearch" onclick="nearbySearch()"/>
	  		  </form>
	  		  
	  		  <p id="latDisplay">lat</p>
	  		  <p id="lngDisplay">lng</p>
	  		  <p id="nearbySearchResult">empty</p>


          <h2 class="my-3">Reviews Section</h2>

        <div id="review1" class="container-fluid">
          <h3>Review 1</h3>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nec lorem non tellus gravida pretium non a enim. In diam massa, blandit sit amet augue et,
             ullamcorper interdum eros. Praesent ut ante convallis, euismod arcu quis, porta felis. Sed scelerisque placerat augue sed mollis. Donec et mauris id orci accumsan
             ullamcorper. Curabitur non leo ligula. Integer in nulla placerat, facilisis risus non, viverra magna. Vestibulum vitae pulvinar est. Quisque sit amet sapien ut
             magna tincidunt aliquam vitae vitae urna. Aliquam egestas sem ac nulla malesuada convallis. Quisque feugiat, metus ullamcorper lobortis elementum, mi mauris
             lobortis massa, quis aliquet erat ante ut dolor. Praesent non dolor eget ante venenatis tempor. Ut vel enim lorem. Aenean vitae est justo. Nullam scelerisque
             elit eu odio tristique vehicula. Donec volutpat, nisi nec facilisis ultricies, nisl erat pulvinar leo, a ultricies purus felis vitae lectus.</p>
        </div>
        <div id="review2" class="container-fluid">
          <h3>Review 2</h3>
          <p>Cras blandit augue augue, sit amet interdum tortor facilisis vitae. Duis mi eros, scelerisque nec sollicitudin nec, accumsan at metus. Duis sit amet metus nisl.
             Nullam molestie ex vitae lacus pharetra tempor a non orci. Ut interdum libero sed semper consectetur. Cras fermentum ligula augue, eu consequat lorem scelerisque
             vitae. Donec eu purus et felis rutrum finibus. Morbi sed mollis quam, non luctus dui.</p>
        </div>
        <div id="review3" class="container-fluid">
          <h3>Review 3</h3>
          <p>Integer accumsan porttitor purus et posuere. Suspendisse potenti. Cras viverra, augue a feugiat molestie, dui magna tincidunt leo, ac commodo lorem nulla ac magna.
             Quisque dapibus elementum vestibulum. Aliquam tincidunt tempor sem, sit amet scelerisque mi consequat ut. Fusce vel justo non magna tincidunt maximus a vel nulla.</p>
         </div>

         <div ng-app="myapp" ng-controller="ctrl1">
           <ul id="myList"></ul>
           <div id="loadMore" ng-click="showMore()">Load more</div>
           <div id="showLess" ng-click="showLess()">Show less</div>
         </div>
      </div>
      <!-- /.row -->

      <!-- Related Projects Row -->
      <h3 class="my-4">Related Projects</h3>

      <div class="row">

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="http://placehold.it/500x300" alt="">
          </a>
        </div>

      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->

    <!-- The Modal -->
    <div id="id01" class="modal">
      <span onclick="document.getElementById('id01').style.display='none'"
    class="close" title="Close Modal">&times;</span>

      <!-- Modal Content -->
      <form class="modal-content animate" action="/action_page.php">
        <div class="container">
          <label for="uname"><b>Username</b></label>
          <input type="text" placeholder="Enter Username" name="uname" required>

          <label for="psw"><b>Password</b></label>
          <input type="password" placeholder="Enter Password" name="psw" required>

          <button type="submit">Log In</button>
          <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
        </div>

        <div class="container" style="background-color:#f1f1f1">
          <span class="psw">Don't have an account? <a href="#" onclick="document.getElementById('id02').style.display='block';
                document.getElementById('id01').style.display='none'" class="cancelbtn">Register Here</a></span>
        </div>
      </form>
    </div>

    <!-- The Modal (contains the Sign Up form) -->
    <div id="id02" class="modal">
      <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">times;</span>
      <form class="modal-content" action="/action_page.php">
        <div class="container">
          <h1>Sign Up</h1>
          <p>Please fill in this form to create an account.</p>
          <hr>

          <label for="uname"><b>Username</b></label>
          <input type="text" placeholder="Enter your Username" name="uname" required>

          <label for="email"><b>Email</b></label>
          <input type="text" placeholder="Enter your Email" name="email" required>

          <label for="psw"><b>Password</b></label>
          <input type="password" placeholder="Enter your Password" name="psw" required>

          <label for="psw-repeat"><b>Repeat Password</b></label>
          <input type="password" placeholder="Repeat your Password" name="psw-repeat" required>

          <div class="clearfix">
            <button type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Cancel</button>
            <button type="submit">Sign Up</button>
          </div>
        </div>
      </form>
    </div>

    <!-- Footer -->
    <footer class="py-5 bg-info">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Your Website 2018</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- JavaScript -->
	<script src="js/mongodb.js" type="text/javascript"></script>
	
	<script>
	function autoSubmit() {
				
		setTimeout(autoSubmit, 200);
	}
	
	function putNearbySearchMarkers() {
		document.getElementById("nearbySearchResult").innerHTML = nearbyStoresArr;
		addNearbySearchMarkers();
	}
				
	var userRecommendationsArr = new Array();
	<%if(userRecommendations != null) {%>
		userRecommendationsArr = new Array(<%=userRecommendations.length%>);
		<%for (int i=0; i < userRecommendations.length; i++) {%>
			userRecommendationsArr[<%=i%>] = <%=userRecommendations[i]%>;
		<%}%>
	<%}%>
	
	var nearbyStoresArr = new Array();
	<%if(nearbyStores != null) {%>
		nearbyStoresArr = new Array(<%=nearbyStores.length%>);
		<%for (int i=0; i < nearbyStores.length; i++) {%>
			nearbyStoresArr[<%=i%>] = <%=nearbyStores[i]%>;
		<%}%>
	<%}%>	
	
	function updateLatAndLng() {
		document.getElementById("latDisplay").innerHTML = lat.toString();
		document.getElementById("lngDisplay").innerHTML = lng.toString();
	}
	
	function addMarker(location) {
    	var marker = new google.maps.Marker({
    	position: location,
    	map: map
    	});
    	markers.push(marker);
    }
	
	function addNearbyMarker(location) {
    	var marker = new google.maps.Marker({
    	position: location,
    	map: map
    	});
    	nearbyMarkers.push(marker);
    }
	
	// Sets the map on all markers in the array.
    function setMapOnAll(map) {
    	for (var i = 0; i < markers.length; i++) {
      		markers[i].setMap(map);
    	}
    }
	
	// Removes the markers from the map, but keeps them in the array.
    function clearMarkers() {
    	setMapOnAll(null);
	}
	
 	// Deletes all markers in the array by removing references to them.
    function deleteMarkers() {
    	clearMarkers();
    	markers = [];
		nearbyMarkers = [];
    }
	</script>
  </body>
</html>