<?php session_start(); ?>
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
	  // User recommendation search results.
      double[] locationsUserRecommendation = null;
      if ((double[])session.getAttribute("locationsUserRecommendation") != null)
        locationsUserRecommendation = (double[])session.getAttribute("locationsUserRecommendation");

      String[] namesUserRecommendation = null;
      if ((String[])session.getAttribute("namesUserRecommendation") != null)
        namesUserRecommendation = (String[])session.getAttribute("namesUserRecommendation");

      String[] addressesUserRecommendation = null;
      if ((String[])session.getAttribute("addressesUserRecommendation") != null)
        addressesUserRecommendation = (String[])session.getAttribute("addressesUserRecommendation");

      String[] categoriesUserRecommendation = null;
      if ((String[])session.getAttribute("categoriesUserRecommendation") != null)
        categoriesUserRecommendation = (String[])session.getAttribute("categoriesUserRecommendation");

      String[] urlsUserRecommendation = null;
      if ((String[])session.getAttribute("urlsUserRecommendation") != null)
        urlsUserRecommendation = (String[])session.getAttribute("urlsUserRecommendation");

   	  // Nearby search results.
      double[] locationsNearby = null;
      if ((double[])session.getAttribute("locationsNearby") != null)
        locationsNearby = (double[])session.getAttribute("locationsNearby");

      String[] namesNearby = null;
      if ((String[])session.getAttribute("namesNearby") != null)
        namesNearby = (String[])session.getAttribute("namesNearby");

      String[] addressesNearby = null;
      if ((String[])session.getAttribute("addressesNearby") != null)
        addressesNearby = (String[])session.getAttribute("addressesNearby");

      String[] categoriesNearby = null;
      if ((String[])session.getAttribute("categoriesNearby") != null)
        categoriesNearby = (String[])session.getAttribute("categoriesNearby");

      String[] urlsNearby = null;
      if ((String[])session.getAttribute("urlsNearby") != null)
        urlsNearby = (String[])session.getAttribute("urlsNearby");

   	  // Category search results.
      double[] locationsCategory = null;
      if ((double[])session.getAttribute("locationsCategory") != null)
        locationsCategory = (double[])session.getAttribute("locationsCategory");

      String[] namesCategory = null;
      if ((String[])session.getAttribute("namesCategory") != null)
        namesCategory = (String[])session.getAttribute("namesCategory");

      String[] addressesCategory = null;
      if ((String[])session.getAttribute("addressesCategory") != null)
        addressesCategory = (String[])session.getAttribute("addressesCategory");

      String[] categoriesCategory = null;
      if ((String[])session.getAttribute("categoriesCategory") != null)
        categoriesCategory = (String[])session.getAttribute("categoriesCategory");

      String[] urlsCategory = null;
      if ((String[])session.getAttribute("urlsCategory") != null)
        urlsCategory = (String[])session.getAttribute("urlsCategory");

      Long endTime = System.nanoTime();
      Long startTime = null;
      if ((Long)session.getAttribute("startTime") != null)
        startTime = (Long)session.getAttribute("startTime");
      Long elapseTimeNano = 0l;
      if (endTime != null && startTime != null)
        elapseTimeNano = endTime - startTime;
      float elapseTime = (float)(elapseTimeNano/1E9);
    %>
  </head>

  <body onload="putUserRecommendationsMarkers();putNearbySearchMarkers();putCategorySearchMarkers()">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-info fixed-top">
      <div class="container">
	<img class="logo" src="img/logo.png" alt="Discounts Discovery" href="index.jsp">
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
             <!--<li class="nav-item">
              <a class="nav-link" href="topdeals.jsp">Top Deals</a>
            </li>
          -->
            <li class="nav-item">
              <div class="wrap">
               <form class="search" action="topdeals.jsp" style="margin:ato;max-width:300px">
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
      <h1 class="my-4"><!--Page Heading -->
        <small><!--Secondary Text--></small>
      </h1>

      <!-- Portfolio Item Row -->
      <div class="row">

        <div class="col-md-8">
          <h1>See the best deals on the map!</h1>

          <div id="map" style="width:750px;height:400px;"></div>
              <script>
                // Note: This example requires that you consent to location sharing when
                // prompted by your browser. If you see the error "The Geolocation service
                // failed.", it means you probably did not give permission for the browser to
                // locate you.
                var map;
                var lat = 0.0;
            	var lng = 0.0;
            	var markers = [];
            	var recommendationMarkers = [];
            	var recommendationInfoWindows = [];
            	var nearbyMarkers = [];
            	var nearbyInfoWindows = [];
            	var categoryMarkers = [];
            	var categoryInfoWindows = [];

                function initMap() {
                  map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 53.467459, lng: -2.233958},
                    zoom: 12
                  });

                  map.addListener('click', function(event) {
                	  deleteClickMarkers();
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

                      //zoom in map
                      //map.setCenter(pos);
                      //map.setZoom(12);
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


          <div style="width:100%">
              <form action="DiscountDiscovery" method="post">
                <input type="hidden" id="usernameUserRecommendation" name="usernameUserRecommendation" value=""/>
                <input type="hidden" id="isUserRecommendation" name="isUserRecommendation" value="false"/>
    			<input type="hidden" id="latUserRecommendation" name="latUserRecommendation" value="0.0"/>
    			<input type="hidden" id="lngUserRecommendation" name="lngUserRecommendation" value="0.0"/>
    			Max num of results: <input type="text" id="maxNumOfResultsUserRecommendation" name="maxNumOfResultsUserRecommendation" value="5" style="width:10%">
    			Search radius (m):
    			<select id="radiusUserRecommendation" name="radiusUserRecommendation">
    			  <option value="500">500</option>
    			  <option value="1000">1000</option>
    			  <option value="2000">2000</option>
    			  <option value="3000">3000</option>
    			 </select>
	  			<br>
	  			<input type="submit" value="User Recommendation" onclick="userRecommendation();deleteMarkers()" style="width:30%"/>
	  		  </form>
	  		  <br>
              <form action="DiscountDiscovery" method="post">
                <input type="hidden" id="usernameNearby" name="usernameNearby" value=""/>
                <input type="hidden" id="isNearby" name="isNearby" value="false"/>
    			<input type="hidden" id="latNearby" name="latNearby" value="0.0"/>
    			<input type="hidden" id="lngNearby" name="lngNearby" value="0.0"/>
    			Max num of results: <input type="text" id="maxNumOfResultsNearby" name="maxNumOfResultsNearby" value="5" style="width:10%">
	  			Search radius (m):
    			<select id="radiusNearby" name="radiusNearby">
    			  <option value="500">500</option>
    			  <option value="1000">1000</option>
    			  <option value="2000">2000</option>
    			  <option value="3000">3000</option>
    			 </select>
	  			<br>
	  			<input type="submit" value="Nearby Search" onclick="nearbySearch();deleteMarkers()" style="width:30%"/>
	  		  </form>
	  		  <br>
			  <form action="DiscountDiscovery" method="post">
                <input type="hidden" id="usernameCategory" name="usernameCategory" value=""/>
                <input type="hidden" id="isCategory" name="isCategory" value="false"/>
    			<input type="hidden" id="latCategory" name="latCategory" value="0.0"/>
    			<input type="hidden" id="lngCategory" name="lngCategory" value="0.0"/>
    			Max num of results: <input type="text" id="maxNumOfResultsCategory" name="maxNumOfResultsCategory" value="5" style="width:10%">
    			Category:
    			<select id="categoryCategory" name="categoryCategory">
    			  <option value="Asian Fusion">Asian Fusion</option>
    			  <option value="Australian">Australian</option>
    			  <option value="Basque">Basque</option>
    			  <option value="Breakfast & Brunch">Breakfast & Brunch</option>
    			  <option value="Buffets">Buffets</option>
    			  <option value="Burgers">Burgers</option>
    			  <option value="Cafes">Cafes</option>
    			  <option value="Chicken Shop">Chicken Shop</option>
    			  <option value="Chinese">Chinese</option>
    			  <option value="Comfort Food">Comfort Food</option>
    			  <option value="Danish">Danish</option>
			      <option value="Fast Food">Fast Food</option>
			      <option value="Gastropubs">Gastropubs</option>
			      <option value="Halal">Halal</option>
			      <option value="Indian">Indian</option>
			      <option value="Italian">Italian</option>
			      <option value="Japanese">Japanese</option>
			      <option value="Korean">Korean</option>
			      <option value="Pakistani">Pakistani</option>
			      <option value="Pan Asian">Pan Asian</option>
			      <option value="Persian">Persian</option>
			      <option value="Pizza">Pizza</option>
			      <option value="Pub Food">Pub Food</option>
			      <option value="Sandwiches">Sandwiches</option>
			      <option value="Spanish">Spanish</option>
			      <option value="Thai">Thai</option>
			      <option value="Turkish">Turkish</option>
			      <option value="Vegetarian">Vegetarian</option>
			    </select>
			    Search radius (m):
    			<select id="radiusCategory" name="radiusCategory">
    			  <option value="500">500</option>
    			  <option value="1000">1000</option>
    			  <option value="2000">2000</option>
    			  <option value="3000">3000</option>
    			 </select>
			    <br>
	  			<input type="submit" value="Category Search" onclick="categorySearch();deleteMarkers()" style="width:30%"/>
	  		  </form>
	  		  <br>
	  		  <button type="button" onclick="deleteMarkers()" style="width:30%">Remove all markers</button>
	  		  <br><br>
	  		  <p id="latDisplay">lat</p>
	  		  <p id="lngDisplay">lng</p>
	  		  <p id="searchDuration">Search took <%=elapseTime %> seconds to complete
	      </div>


          <h2 class="my-3">Reviews Section</h2>


       <div class="row">
          <div class=" blogBox">
             <div class="item featured">
                <div class="blogTxt">
                   <div class="blogCategory">
                     <h3>
                      <a href="">Review 1</a>
                    </h3>
                   </div>
                      <h4>
                      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nec lorem non tellus gravida pretium non a enim. In diam massa, blandit sit amet augue et,
                      ullamcorper interdum eros. Praesent ut ante convallis, euismod arcu quis, porta felis. Sed scelerisque placerat augue sed mollis. Donec et mauris id orci accumsan
                      </p>
                    </h4>
                </div>
             </div>
          </div>
          <div class="blogBox moreBox" >
             <div class="item">
                <div class="blogTxt">
                   <div class="blogCategory">
                     <h3>
                      <a href="">Review 2</a>
                    </h3>
                   </div>
                   <h4>
                      Ea delicata deterru isset concluda turque
                   </h4>
                </div>
             </div>
          </div>
          <div class="blogBox moreBox" >
             <div class="item">
                <div class="blogTxt">
                   <div class="blogCategory">
                     <h3>
                      <a href="">Review 3</a>
                    </h3>
                   </div>
                   <h4>
                      No vim quis quodsi, etiam quaestio euripidis
                   </h4>
                </div>
             </div>
          </div>
          <div class="blogBox moreBox" >
             <div class="item">
                <div class="blogTxt">
                   <div class="blogCategory">
                     <h3>
                      <a href="">Review 4</a>
                    </h3>
                   </div>
                   <h4>
                      Qui an alii magna consectetuer
                   </h4>
                </div>
             </div>
          </div>
          <div class="blogBox moreBox" style="display: none;">
             <div class="item">
                <div class="blogTxt">
                   <div class="blogCategory">
                     <h3>
                      <a href="">Review 5</a>
                    </h3>
                   </div>
                   <h4>
                      Integre voluptatum cu quo iriure docendi senserit
                   </h4>
                </div>
             </div>
          </div>
          <div class="blogBox moreBox" style="display: none;">
             <div class="item">
                <div class="blogTxt">
                   <div class="blogCategory">
                     <h3>
                      <a href="">Review 6</a>
                    </h3>
                   </div>
                   <h4>
                      Pro brute causae aliquip ad
                   </h4>
                </div>
             </div>
          </div>
          <div class="blogBox moreBox" style="display: none;">
             <div class="item">
                <div class="blogTxt">
                   <div class="blogCategory">
                     <h3>
                      <a href="">Review 7</a>
                    </h3>
                   </div>
                   <h4>
                      Lorem ipsum dolor sit amet, consect adipiscing elit
                   </h4>
                </div>
             </div>
          </div>
          <div id="loadMore" style="">
             <a href="#">Load More</a>
          </div>
       </div>
    </div>

      <!-- /.row -->

      <!-- Related Projects Row
      <h3 class="my-4"><Related Projects</h3> -->

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
      <form class="modal-content animate" id="lca-form" method="post">
        <div class="container">
          <label for="inputUsername">Username</label>
          <input type="name" name="username" id="inputUsername" placeholder="Username" required autofocus>

          <!--<label for="inputUsername">Email</label>
          <input type="email" name="email" id="inputUsername" placeholder="Username" required>
          <label for="inputPassword">Password</label>
          <input type="password" name="confpassword" id="inputPassword" placeholder="Password" required>-->

          <label for="inputPassword">Confirm Password</label>
          <input type="password" name="password" id="inputPassword" placeholder="Password" required>

          <div class="clearfix">

            <button type="submit" id="btn-signin">Sign in</button>
            <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
            <button type="submit" id="btn-createaccount">Sign Up</button>
        </div>
      </form>
    </div>
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

	<!-- Load More button -->

	<script>
	$( document ).ready(function ()
	{
	  $(".moreBox").slice(0, 3).show();
	    if ($(".blogBox:hidden").length != 0)
	    {
	      $("#loadMore").show();
	    }
	  $("#loadMore").on('click', function (e)
	  {
	    e.preventDefault();
	    $(".moreBox:hidden").slice(0, 6).slideDown();
	    if ($(".moreBox:hidden").length == 0)
	    {
	      $("#loadMore").fadeOut('slow');
	    }
	  });
	});
	</script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
      $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
      });
      if ($('#lca-form')[0]) {
        document.getElementById("btn-signin").onclick = function() {
          document.getElementById("lca-form").action = "login.php";
        };
        document.getElementById("btn-createaccount").onclick = function() {
          document.getElementById("lca-form").action = "createaccount.php";
        };
      }
      $('.datalink').on('click', function(e){
        //preventing the default link redirection
        e.preventDefault();

        $('.myValue').val($(this).data('value'));
        $(this).closest('form').submit();
      });
    });
    </script>

	<!-- JavaScript -->
	<script src="js/mongodb.js" type="text/javascript"></script>

	<script>
	// User recommendation search results.
	var locationsUserRecommendationArr = new Array();
	<%if(locationsUserRecommendation != null) {%>
		locationsUserRecommendationArr = new Array(<%=locationsUserRecommendation.length%>);
		<%for (int i=0; i < locationsUserRecommendation.length; i++) {%>
			locationsUserRecommendationArr[<%=i%>] = <%=locationsUserRecommendation[i]%>;
		<%}%>
	<%}%>

	var namesUserRecommendationArr = new Array();
	<%if(namesUserRecommendation != null) {%>
		namesUserRecommendationArr = new Array(<%=namesUserRecommendation.length%>);
		<%for (int i=0; i < namesUserRecommendation.length; i++) {%>
			namesUserRecommendationArr[<%=i%>] = "<%=namesUserRecommendation[i]%>";
		<%}%>
	<%}%>

	var addressesUserRecommendationArr = new Array();
	<%if(addressesUserRecommendation != null) {%>
		addressesUserRecommendationArr = new Array(<%=addressesUserRecommendation.length%>);
		<%for (int i=0; i < addressesUserRecommendation.length; i++) {%>
			addressesUserRecommendationArr[<%=i%>] = "<%=addressesUserRecommendation[i]%>";
		<%}%>
	<%}%>

	var categoriesUserRecommendationArr = new Array();
	<%if(categoriesUserRecommendation != null) {%>
		categoriesUserRecommendationArr = new Array(<%=categoriesUserRecommendation.length%>);
		<%for (int i=0; i < categoriesUserRecommendation.length; i++) {%>
			categoriesUserRecommendationArr[<%=i%>] = "<%=categoriesUserRecommendation[i]%>";
		<%}%>
	<%}%>

	var urlsUserRecommendationArr = new Array();
	<%if(urlsUserRecommendation != null) {%>
		urlsUserRecommendationArr = new Array(<%=urlsUserRecommendation.length%>);
		<%for (int i=0; i < urlsUserRecommendation.length; i++) {%>
		urlsUserRecommendationArr[<%=i%>] = "<%=urlsUserRecommendation[i]%>";
		<%}%>
	<%}%>

	// Nearby search results.
	var locationsNearbyArr = new Array();
	<%if(locationsNearby != null) {%>
		locationsNearbyArr = new Array(<%=locationsNearby.length%>);
		<%for (int i=0; i < locationsNearby.length; i++) {%>
			locationsNearbyArr[<%=i%>] = <%=locationsNearby[i]%>;
		<%}%>
	<%}%>

	var namesNearbyArr = new Array();
	<%if(namesNearby != null) {%>
		namesNearbyArr = new Array(<%=namesNearby.length%>);
		<%for (int i=0; i < namesNearby.length; i++) {%>
			namesNearbyArr[<%=i%>] = "<%=namesNearby[i]%>";
		<%}%>
	<%}%>

	var addressesNearbyArr = new Array();
	<%if(addressesNearby != null) {%>
		addressesNearbyArr = new Array(<%=addressesNearby.length%>);
		<%for (int i=0; i < addressesNearby.length; i++) {%>
			addressesNearbyArr[<%=i%>] = "<%=addressesNearby[i]%>";
		<%}%>
	<%}%>

	var categoriesNearbyArr = new Array();
	<%if(categoriesNearby != null) {%>
		categoriesNearbyArr = new Array(<%=categoriesNearby.length%>);
		<%for (int i=0; i < categoriesNearby.length; i++) {%>
			categoriesNearbyArr[<%=i%>] = "<%=categoriesNearby[i]%>";
		<%}%>
	<%}%>

	var urlsNearbyArr = new Array();
	<%if(urlsNearby != null) {%>
		urlsNearbyArr = new Array(<%=urlsNearby.length%>);
		<%for (int i=0; i < urlsNearby.length; i++) {%>
			urlsNearbyArr[<%=i%>] = "<%=urlsNearby[i]%>";
		<%}%>
	<%}%>

	// Category search results.
	var locationsCategoryArr = new Array();
	<%if(locationsCategory != null) {%>
		locationsCategoryArr = new Array(<%=locationsCategory.length%>);
		<%for (int i=0; i < locationsCategory.length; i++) {%>
			locationsCategoryArr[<%=i%>] = <%=locationsCategory[i]%>;
		<%}%>
	<%}%>

	var namesCategoryArr = new Array();
	<%if(namesCategory != null) {%>
		namesCategoryArr = new Array(<%=namesCategory.length%>);
		<%for (int i=0; i < namesCategory.length; i++) {%>
			namesCategoryArr[<%=i%>] = "<%=namesCategory[i]%>";
		<%}%>
	<%}%>

	var addressesCategoryArr = new Array();
	<%if(addressesCategory != null) {%>
		addressesCategoryArr = new Array(<%=addressesCategory.length%>);
		<%for (int i=0; i < addressesCategory.length; i++) {%>
			addressesCategoryArr[<%=i%>] = "<%=addressesCategory[i]%>";
		<%}%>
	<%}%>

	var categoriesCategoryArr = new Array();
	<%if(categoriesCategory != null) {%>
		categoriesCategoryArr = new Array(<%=categoriesCategory.length%>);
		<%for (int i=0; i < categoriesCategory.length; i++) {%>
			categoriesCategoryArr[<%=i%>] = "<%=categoriesCategory[i]%>";
		<%}%>
	<%}%>

	var urlsCategoryArr = new Array();
	<%if(urlsCategory != null) {%>
		urlsCategoryArr = new Array(<%=urlsCategory.length%>);
		<%for (int i=0; i < urlsCategory.length; i++) {%>
			urlsCategoryArr[<%=i%>] = "<%=urlsCategory[i]%>";
		<%}%>
	<%}%>


	function putUserRecommendationsMarkers() {
		addUserRecommendationMarkers();
	}

	function putNearbySearchMarkers() {
		addNearbySearchMarkers();
	}

	function putCategorySearchMarkers() {
		addCategorySearchMarkers();
	}

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

	function addUserRecommendationMarker(location, name, address, category, url) {
    var discountsAreAvailable = 0
    var apiURL = new URL("https://api.yelp.com/v3/businesses/search?term=name&attributes=deals?key=7QBW9KRcTUzgTOXEpvTeNuR7aZvdTwHK4vHJD-Ft3bXakFE1snALoHu-nbRU0sAdRczIyOmdaOJSVr3Nb_TzwaAYWiEHIf-SI_1RGjSOGEKYW8irlD7KND-pxnmdWnYx")
    var authenticatedURL = apiURL.openConnection()
    var contentString = '<h1 id="userRecommendationHeading" class="firstHeading">'
			+ name + '</h1>'
			+ '<p><b>Address: </b>' + address + '</p>'
			+ '<p><b>Category: </b>' + category + '</p>'
			+ '<p><b>Website: </b><a href="http://' + url + '">' + url + '</a></p>';
	  	var infowindow = new google.maps.InfoWindow({
		    content: contentString
		  });

      var discountsAreAvailable = 0;
      $.get(authenticatedURL, function(data){
           {
          // If there is a result
             if (data.total > 0)
                 {
                     discountsAreAvailable = 1;
                 }
           }
      })


      if (discountsAreAvailable == 1)
      {
		    var marker = new google.maps.Marker({
	        	position: location,
	        	map: map,
        		title: 'Discounts are available for ' + name
	        });
      }
      else
      {
		    var marker = new google.maps.Marker({
	        	position: location,
	        	map: map,
        		title: 'Discounts are not available for ' + name
	        });
      }


		marker.addListener('click', function() {
    	    infowindow.open(map, marker);
    	    map.panTo(marker.getPosition());
    	  });
		recommendationInfoWindows.push(infowindow);
		recommendationMarkers.push(marker);
	}

	function addNearbySearchMarker(location, name, address, category, url) {
		var contentString = '<h1 id="nearbyHeading" class="firstHeading">'
			+ name + '</h1>'
			+ '<p><b>Address: </b>' + address + '</p>'
			+ '<p><b>Category: </b>' + category + '</p>'
			+ '<p><b>Website: </b><a href="http://' + url + '">' + url + '</a></p>';
		var infowindow = new google.maps.InfoWindow({
		    content: contentString
		  });
    	var marker = new google.maps.Marker({
    		position: location,
    		map: map,
    		title: name
    	});
    	marker.addListener('click', function() {
    	    infowindow.open(map, marker);
    	    map.panTo(marker.getPosition());
    	  });
    	nearbyInfoWindows.push(infowindow);
    	nearbyMarkers.push(marker);
    }

	function addCategorySearchMarker(location, name, address, category, url) {
		var contentString = '<h1 id="categoryHeading" class="firstHeading">'
			+ name + '</h1>'
			+ '<p><b>Address: </b>' + address + '</p>'
			+ '<p><b>Category: </b>' + category + '</p>'
			+ '<p><b>Website: </b><a href="http://' + url + '">' + url + '</a></p>';
		var infowindow = new google.maps.InfoWindow({
		    content: contentString
		  });
    	var marker = new google.maps.Marker({
    		position: location,
    		map: map,
    		title: name
    	});
    	marker.addListener('click', function() {
    	    infowindow.open(map, marker);
    	    map.panTo(marker.getPosition());
    	  });
    	categoryInfoWindows.push(infowindow);
    	categoryMarkers.push(marker);
    }

	// Sets the map on all click markers.
	function setMapOnClick(map) {
		for (var i = 0; i < markers.length; i++) {
      		markers[i].setMap(map);
    	}
	}

	// Sets the map on all markers in the array.
    function setMapOnAll(map) {
    	for (var i = 0; i < markers.length; i++) {
      		markers[i].setMap(map);
    	}
    	for (var i = 0; i < recommendationMarkers.length; i++) {
    		recommendationMarkers[i].setMap(map);
    	}
    	for (var i = 0; i < nearbyMarkers.length; i++) {
    		nearbyMarkers[i].setMap(map);
    	}
    	for (var i = 0; i < categoryMarkers.length; i++) {
    		categoryMarkers[i].setMap(map);
    	}
    }

 	// Removes all click markers from the map, but keeps them in the array.
    function clearClickMarkers() {
    	setMapOnClick(null);
	}

	// Removes the markers from the map, but keeps them in the array.
    function clearMarkers() {
    	setMapOnAll(null);
	}

	// Deletes all click markers.
	function deleteClickMarkers() {
		clearClickMarkers();
	}

 	// Deletes all markers in the array by removing references to them.
    function deleteMarkers() {
    	clearMarkers();
    	markers = [];
		recommendationMarkers = [];
		nearbyMarkers = [];
		categoryMarkers = [];
    }
	</script>

  </body>

</html>
