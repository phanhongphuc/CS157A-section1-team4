<%@ page import="java.sql.*"%>

<%
String name = String.valueOf(session.getAttribute("username"));
if(session == null || name.equals("null")) {
   response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries - Add product to cart</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <script src="js/jquery-1.10.2.js"></script>
  <script src="js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <header class="blog-header py-3">
    <div class="col-12 text-center">
      <h1>Order Up Groceries</h1>
    </div>
  </header>
  
  <div class="card mb-4 shadow-sm">
    <div class="card-header">
      <h2>
        Add product to cart
        <div class="float-right float-bottom h6 mt-3">
          Hi <%= name %>, <br>
          <a href="cart.jsp">Cart</a> / 
          <a href="logout.jsp">Log out</a>
        </div>
      </h2>
    </div>

    <div class="card-body">
      <%
        String cart = String.valueOf(session.getAttribute("cart"));
        if(cart.equals("null")){
            cart = request.getParameter("id");
        } else {
          cart += "," + request.getParameter("id");
        }
        request.getSession().setAttribute("cart", cart);
        //out.println(cart);
      %>
      <div class="alert alert-primary" role="alert">
        Product added to your cart
      </div>
      <a href="home.jsp" class="btn">
        <button type="button" class="btn btn-primary">Back to home page</button>
      </a>
    </div>
  </div>
  
</div>
</body>
</html>
