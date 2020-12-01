<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>

<%
/* check if the user has logined */
String name = String.valueOf(session.getAttribute("username"));
if(session == null || name.equals("null")) {
   response.sendRedirect("login.jsp");
}
%>

<%
/* prepare the hash map of productId -> quantity */
String cart = "''";
HashMap<Integer, Integer> mapCart = new HashMap<Integer, Integer>();
if(session.getAttribute("cart") != null){
  cart = String.valueOf(session.getAttribute("cart"));
  String[] arrayCart = cart.split(",");

  for(String productId:arrayCart) {
    int id = Integer.parseInt(productId);
    if (mapCart.containsKey(id)) {
      mapCart.put(id, mapCart.get(id) + 1);
    } else {
      mapCart.put(id, 1);
    }
  }
}
%>

<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries - Cart</title>
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
        Cart
        <div class="float-right float-bottom h6 mt-3">
          Hi <%= name %>, <br> 
          <a href="logout.jsp">Log out</a>
        </div>
      </h2>
      <hr>
        <a href="home.jsp" class="btn">
          <button type="button" class="btn btn-primary">Back to Homepage</button>
        </a>
    </div>

    <div class="card-body">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <td>Id</td>
            <td>Name</td>
            <td>Unit Price</td>
            <td>Quantity</td>
            <td>Price</td>
          </tr>
        <thead>
        <tbody>
        <%
        String db = "cs157a";
        String user = "root";
        String password = "root";
        try {
          java.sql.Connection con; 
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
          
          Statement stmt = con.createStatement();
          String query = String.format("SELECT * FROM `order-up-groceries`.product WHERE `id` IN (%s)", cart);
          ResultSet rs = stmt.executeQuery(query);
          int total = 0;
          while (rs.next()) {
            int productId = rs.getInt("id");
            String productName = rs.getString("name");
            int unitPrice = rs.getInt("price");
            int quantity = mapCart.get(productId);
            int price = unitPrice * quantity;
            total += price;
        %>
        <tr>
          <td> <%= productId %></td>
          <td> <%= productName %></td>
          <td> $<%= unitPrice %></td>
          <td> <%= quantity %></td>
          <td> $<%= price %></td>
        </tr>
        <%
          }
        %>
       <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><b>Total: $<%= total %></b></td>
        </tr>
        <tbody>
      </table>
    </div>
  </div>
  <div class="card mb-4 shadow-sm">
    <div class="card-header">
      <h2>Check Out</h2>
    </div>
    <div class="card-body">
      <form method="POST" action="checkOut.jsp">
        <div class="form-group">
          <label for="name">Name on credit card</label>
          <input type="text" class="form-control" name="name" placeholder="Enter name on credit card" required>
        </div>
        <div class="form-group">
          <label for="credit">Credit card number (16 digits)</label>
          <input type="text" class="form-control" name="credit" placeholder="Enter credit card number" required>
        </div>
        <div class="form-group">
          <label for="expired">Expired date (MM/YY)</label>
          <input type="text" class="form-control" name="expired" placeholder="Expired date (MM/YY)" required>
        </div>
        <div class="form-group">
          <label for="address">Shipping address</label>
          <input type="text" class="form-control" name="address" placeholder="Enter shipping address" required>
        </div>
        <div class="form-group">
          <input type="hidden" name="total" value=<%= total %>>
          <input type="hidden" name="cart" value=<%= cart %>>
          <button type="submit" class="btn btn-primary">Check out</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
      <%
          rs.close();
          stmt.close();
          con.close();
        } catch(SQLException e) { 
          out.println("SQLException caught: " + e.getMessage());
        }
      %>
