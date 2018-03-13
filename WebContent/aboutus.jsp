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

    <style>
h1 {
    text-align: center;
}
</style>

  </head>

  <body>

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
              <a class="nav-link" href="index.jsp">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">About us</a>
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



      <!-- Our Team Row -->
      <h1 class="my-4">Our Team</h1>

      <div class="row">

        <div class="col-6 col-s-9">
          <p>Denisa</p>
            <img class="mw-100" src="img/denisa.jpg" width="300" height="300"
                 alt="denisa">
        </div>


        <div class="col-6 col-s-9">
          <p>Gabija</p>
            <img class="mw-100" src="img/gabija.jpg" width="300" height="300"
                 alt="gabija">
        </div>

        <div class="col-6 col-s-9">
          <p>Evripidis</p>
            <img class="mw-100" src="img/evripidis.jpg" width="300" height="300"
                 alt="evripidis">
        </div>

        <div class="col-6 col-s-9">
          <p>Oscar</p>
            <img class="mw-100" src="img/oscar.jpg" width="300" height="300"
                 alt="oscar">
        </div>

        <div class="col-6 col-s-9">
          <p>Gabriel</p>
            <img class="mw-100" src="img/gabriel.jpg" width="300" height="300"
                 alt="gabriel">
        </div>

        <div class="col-6 col-s-9">
          <p>Rebecca</p>
            <img class="mw-100" src="img/rebecca.jpg" width="300" height="300"
                 alt="rebecca">
        </div>

        <div class="col-6 col-s-9">
          <p>Jie</p>
            <img class="mw-100" src="img/jie.jpg" width="300" height="300"
                 alt="jie">
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

  </body>

</html>