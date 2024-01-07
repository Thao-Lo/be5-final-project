<!DOCTYPE html>
<%@page import="java.util.Base64"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="entity.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
CategoryDAO categoryDAO = new CategoryDAO();
pageContext.setAttribute("allCategory", categoryDAO.getAllCategories());

String username = null;

UserDAO userDAO = new UserDAO();

username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");

boolean showOtherInputs = false;


boolean isUsernameRegistered = userDAO.isUsernameRegistered(username);
if(!isUsernameRegistered & username != null){
	session.setAttribute("username", username);
	showOtherInputs = true;
}

username = (String) session.getAttribute("username");
if(!isUsernameRegistered && username != null && email != null && password != null){
	String encodedPassword = Base64.getEncoder().encodeToString(password.getBytes());	
	userDAO.registerNewUser(username, email, encodedPassword);	
}

pageContext.setAttribute("isUsernameRegistered", isUsernameRegistered);
pageContext.setAttribute("showOtherInputs", showOtherInputs);

%>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">

  <title>
    Giftos
  </title>

  <!-- slider stylesheet -->
    <link href="css/general.css" type="text/css" rel="stylesheet" />
  
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />
  

</head>

<body>
  <div class="hero_area">
    <!-- header section strats -->
   <header class="header_section">
      <nav class="navbar navbar-expand-lg custom_nav-container ">
        <a class="navbar-brand" href="index.html">
          <span>
            Giftos
          </span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class=""></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav  ">
             <li class="nav-item ">
              <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
           
            <c:forEach items="${allCategory}" var="category">      
            <li class="nav-item">
              <a class="nav-link" href="index.jsp?categoryId=${category.id}">
                ${category.name}
              </a>
            </li>
              </c:forEach>
          </ul>
          <div class="user_option">
            <a href="login.jsp">
              <i class="fa fa-user" aria-hidden="true"></i>
              <span>
                Login
              </span>
            </a>
            <a href="register.jsp">
              <i class="fa fa-shopping-bag" aria-hidden="true"></i>
            </a>
            
             <form action="index.jsp" class = "search-form">
                <input type="text" placeholder="search Giftos" name="searchInput" required>                              
	            <button class="btn nav_search-btn" type="submit">
                <i class="fa fa-search" aria-hidden="true"></i>
              	</button>
            </form>
          </div>
        </div>
      </nav>
    </header>
    <!-- end header section -->

  </div>
  <!-- end hero area -->

  <!-- contact section -->

  <section class="contact_section layout_padding">
    <div class="container px-0">
      <div class="heading_container ">
        <h2 class="">
        Create Account
        </h2>
      </div>
    </div>
    <div class="container container-bg">
      <div class="row">
         <div class="col-md-6 col-lg-3 px-0"></div>
       
         
        <div class="col-md-6 col-lg-6 px-0">
        
        	<c:if test="${!showOtherInputs}">
          <form action="register.jsp" method="post" id="usernameForm">
	         <div>
	            <label>Username </label>
	            <input type="text" placeholder="Username" name="username" minlength="6" autofocus required/>
	            <button>Next</button>
		             <c:if test="${param.username != null && isUsernameRegistered}">
		             	<span style="color: red">This username is unavailable</span>             
		             </c:if>
	           </div>
           </form>  
			 </c:if>
			 
			<c:if test="${showOtherInputs}">			
	        <form  action="" method="post" id="otherInputsForm">         
            <span><strong>Your Username:</strong> ${username}</span>
            <a href="register.jsp">change</a>
            <div>
            <label>Email </label>
              <input class="register-input" type="email" placeholder="sample@email.com" name="email" required/>
            </div>
             <div>
            <label>Password </label>             
	          <input class="register-input" type="password" placeholder="At least 6 characters" name="password" minlength="6" id="input1" required/>
	          <div class="input-with-checkbox">
	         	  <input class = "show-password" type="checkbox" onclick="togglePasswordVisibility('input1')">
	              <label class = "label-show-password">Show Password</label>
	              
              </div>
            </div>
             <div>
            <label>Re - enter Password </label>
              <input class="register-input" type="password" placeholder="" name="password" minlength="6" id="input2" required/>
              <div class="input-with-checkbox">
              <input class = "show-password" type="checkbox" onclick="togglePasswordVisibility('input2')">
              <label class = "label-show-password">Show Password</label>
              </div>
            </div>
          	<br><p id="message"></p>
            <div class="d-flex ">
	             <a href="login.jsp">
		              <button>SEND</button>
	             </a>
            </div>         	
          	<div class="question-sign-in" >Already have an account? <a href="login.jsp">Sign In </a></div>	         
            </form>
            
            </c:if>
          
        </div>
        <div class="col-md-6 col-lg-3 px-0">
         </div>
      </div>
    </div>
  </section>

  <!-- end contact section -->

  <!-- info section -->

  <section class="info_section  layout_padding2-top">
    <div class="social_container">
      <div class="social_box">
        <a href="">
          <i class="fa fa-facebook" aria-hidden="true"></i>
        </a>
        <a href="">
          <i class="fa fa-twitter" aria-hidden="true"></i>
        </a>
        <a href="">
          <i class="fa fa-instagram" aria-hidden="true"></i>
        </a>
        <a href="">
          <i class="fa fa-youtube" aria-hidden="true"></i>
        </a>
      </div>
    </div>
    <div class="info_container ">
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-lg-3">
            <h6>
              ABOUT US
            </h6>
            <p>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed doLorem ipsum dolor sit amet, consectetur adipiscing elit, sed doLorem ipsum dolor sit amet,
            </p>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="info_form ">
              <h5>
                Newsletter
              </h5>
              <form action="#">
                <input type="email" placeholder="Enter your email">
             	 <input type="submit" value="Submit">
              </form>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <h6>
              NEED HELP
            </h6>
            <p>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed doLorem ipsum dolor sit amet, consectetur adipiscing elit, sed doLorem ipsum dolor sit amet,
            </p>
          </div>
          <div class="col-md-6 col-lg-3">
            <h6>
              CONTACT US
            </h6>
            <div class="info_link-box">
              <a href="">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span> Gb road 123 london Uk </span>
              </a>
              <a href="">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>+01 12345678901</span>
              </a>
              <a href="">
                <i class="fa fa-envelope" aria-hidden="true"></i>
                <span> demo@gmail.com</span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- footer section -->
    <footer class=" footer_section">
      <div class="container">
        <p>
          &copy; <span id="displayYear"></span> All Rights Reserved By
          <a href="https://html.design/">Free Html Templates</a>
        </p>
      </div>
    </footer>
    <!-- footer section -->

  </section>

  <!-- end info section -->

   <script>
        // Get references to the input elements and the message element
        const input1 = document.getElementById('input1');
        const input2 = document.getElementById('input2');
        const message = document.getElementById('message');

        // Add an event listener to input2 to check the values
        input2.addEventListener('input', function() {
            if (input1.value === input2.value) {
                message.textContent = 'Passwords match!';
                message.style.color = 'green';
            } else {
                message.textContent = 'Passwords do not match!';
                message.style.color = 'red';
            }
        });
    </script>
<script>
function togglePasswordVisibility(inputId) {
  var x = document.getElementById(inputId);
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}

// Call the function with the appropriate input IDs
document.getElementById("showPassword1").addEventListener("click", function() {
  togglePasswordVisibility("input1");
});

document.getElementById("showPassword2").addEventListener("click", function() {
  togglePasswordVisibility("input2");
});
</script>
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <script src="js/custom.js"></script>


</body>

</html>