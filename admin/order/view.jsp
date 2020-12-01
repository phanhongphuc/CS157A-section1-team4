<%@ page import="java.sql.*"%>

<%
String name = String.valueOf(session.getAttribute("username"));
String role = String.valueOf(session.getAttribute("userRole"));
if(session == null || name == null || !role.equals("admin")) {
   response.sendRedirect("../login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries Admin - Order Edit</title>
  <link href="../../css/bootstrap.min.css" rel="stylesheet">
  <script src="../../js/jquery-1.10.2.js"></script>
  <script src="../../js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <header class="blog-header py-3">
    <div class="col-12 text-center">
      <h1>Order Up Groceries</h1>
    </div>
  </header>
  
  <%@include file="../menu.jsp" %>
  
  <div class="card mb-4 shadow-sm">
    <div class="card-header">
      <h2>Order information</h2>
      <hr>
      <a href="list.jsp" class="btn">
        <button type="button" class="btn btn-primary">Back to order list</button>
      </a>
      <a href="../home.jsp" class="btn">
        <button type="button" class="btn btn-primary">Back to Homepage</button>
      </a>
    </div>

    <div class="card-body">
      <% if(request.getParameter("orderId") != null) {
          String customer = "";
          String date = "";
          String total = "";
          String shippingAddress = "";
          String status = "";
          String creditName = "";
          String creditNumber = "";
          String creditExpired = "";
          
          String orderId = request.getParameter("orderId");
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            String query = String.format("SELECT * FROM `order-up-groceries`.`order`, `order-up-groceries`.`user`, `order-up-groceries`.`customerPlaceOrder` WHERE `order`.`id` = '%s' AND `customerPlaceOrder`.`customerId` = `user`.`id` AND `customerPlaceOrder`.`orderId` = '%s' ", orderId, orderId);
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
              customer = rs.getString("username");
              date = rs.getString("date");
              total = rs.getString("total");
              shippingAddress = rs.getString("address");
              status = rs.getString("status");
              creditName = rs.getString("name");
              creditNumber = rs.getString("credit");
              creditExpired = rs.getString("expired");
            }
            rs.close();
            stmt.close();
            con.close();
          } catch(SQLException e) { 
             out.println("SQLException caught: " + e.getMessage());
          }
      %>
        <table class="table table-striped table-sm">
          <tr>
            <td>Order Id</td>
            <td><%= orderId %></td>
          </tr>
          <tr>
            <td>Customer</td>
            <td><%= customer %></td>
          </tr>
          <tr>
            <td>Order date</td>
            <td><%= date %></td>
          </tr>
          <tr>
            <td>Total</td>
            <td>$<%= total %></td>
          </tr>
          <tr>
            <td>Shipping address</td>
            <td><%= shippingAddress %></td>
          </tr>
          <tr>
            <td>Status</td>
            <td><%= status %></td>
          </tr>
          <tr>
            <td>Name on credit card</td>
            <td><%= creditName %></td>
          </tr>
          <tr>
            <td>Credit card number</td>
            <td><%= creditNumber %></td>
          </tr>
          <tr>
            <td>Credit card  expired date</td>
            <td><%= creditExpired %></td>
          </tr>
        </table>
    </div>
  </div>

  <div class="card mb-4 shadow-sm">
    <div class="card-header">
      <h2>
        Products
      </h2>
      <hr>
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
        try {
          java.sql.Connection con; 
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
          
          Statement stmt = con.createStatement();
          String query = String.format("SELECT id, name, `productInOrder`.`price`, `productInOrder`.`quantity` FROM `order-up-groceries`.`productInOrder`, `order-up-groceries`.`product` WHERE `orderId` = '%s' AND `product`.`id` = `productId`", orderId);
          ResultSet rs = stmt.executeQuery(query);
          int totalPrice = 0;
          while (rs.next()) {
            int productId = rs.getInt("id");
            String productName = rs.getString("name");
            int unitPrice = rs.getInt("price");
            int quantity = rs.getInt("quantity");
            int price = unitPrice * quantity;
            totalPrice += price;
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
          <td><b>Total: $<%= totalPrice %></b></td>
        </tr>
        <tbody>
      </table>
      <a href="delivered.jsp?orderId=<%= orderId %>" class="btn">
        <button type="button" class="btn btn-primary">Set status to Delivered</button>
      </a>
    </div>
  </div>
        <% 
        } catch(SQLException e) { 
         out.println("SQLException caught: " + e.getMessage());
        } 
        %>
</div>
</body>
</html>
<% } %>
