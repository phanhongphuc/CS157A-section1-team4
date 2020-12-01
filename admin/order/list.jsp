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
  <title>Order Up Groceries Admin - Order List</title>
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
      <h2>Order List</h2>
       <a href="../home.jsp" class="btn">
        <button type="button" class="btn btn-primary">Back to Homepage</button>
      </a>
    </div>

    <div class="card-body">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <td>Id</td>
            <td>Customer</td>
            <td>Date</td>
            <td>Total</td>
            <td>Shipping address</td>
            <td>Status</td>
            <td>Action</td>
          </tr>
        <thead>
        <tbody>
      <%
          String orderName = request.getParameter("orderName");
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            String query = "SELECT * FROM `order-up-groceries`.`order`, `order-up-groceries`.`user`, `order-up-groceries`.`customerPlaceOrder` WHERE `order`.`id` = `customerPlaceOrder`.`orderId` AND `customerPlaceOrder`.`customerId` = `user`.`id`";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
      %>
              <tr>
                <td> <%= rs.getInt("orderId") %></td>
                <td> <%= rs.getString("username") %></td>
                <td> <%= rs.getString("date") %></td>
                <td> $<%= rs.getString("total") %></td>
                <td> <%= rs.getString("address") %></td>
                <td> <%= rs.getString("status") %></td>
                <td>
                  <a href="view.jsp?orderId=<%= rs.getInt("orderId") %>" class="btn">
                    <button type="button" class="btn btn-primary">View</button>
                  </a>
                </td>
              </tr>
      <%
            }
            rs.close();
            stmt.close();
            con.close();
          } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
          }
      %>
        <tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
