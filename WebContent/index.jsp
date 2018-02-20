<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Portfolio Item - Start Bootstrap Template</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/portfolio-item.css" rel="stylesheet">
	
	<%
      double[] userRecommendations = null;
        	if ((double[])session.getAttribute("userRecommendations") != null)
        	  userRecommendations = (double[])session.getAttribute("userRecommendations");
    %>

  </head>

  <body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-info fixed-top">
      <div class="container">
        <a class="navbar-brand" href="#">DISCOUNTS DISCOVERY</a>
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
               <div class="search">
                 <input type="text" class="searchTerm" placeholder="What are you looking for?">
                 <button type="submit" class="searchButton">
                 <i class="fa fa-search"></i>
                 </button>
               </div>
              </div>
            </li>

            <li class="nav-item">
              <a class="nav-link" href="#">Log In</a>
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

          <div id="googleMap" style="width:100%;height:400px;"></div>

          <script>
          function myMap() {
          var mapProp= {
              center:new google.maps.LatLng(51.508742,-0.120850),
              zoom:5,
          };
          var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
          }
          </script>

          <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAQ5InZv-AH3sMeMTKwWUDJ84Vm5bk9P6M&callback=myMap"></script>
        </div>

        <div class="col-md-4">
          <h3 class="my-3">Project Description</h3>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae. Sed dui lorem, adipiscing in adipiscing et, interdum nec metus. Mauris ultricies, justo eu convallis placerat, felis enim.</p>
          <h3 class="my-3">Project Details</h3>
          <ul>
            <li>Lorem Ipsum</li>
            <li>Dolor Sit Amet</li>
            <li>Consectetur</li>
            <li>Adipiscing Elit</li>
          </ul>
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
				
	var userRecommendationsArr = new Array();
	<%if(userRecommendations != null) {%>
		userRecommendationsArr = new Array(<%=userRecommendations.length%>);
		<%for (int i=0; i < userRecommendations.length; i++) {%>
			userRecommendationsArr[<%= i %>] = <%=userRecommendations[i] %>;
		<%}%>
	<%}%>
	</script>

  </body>

</html>