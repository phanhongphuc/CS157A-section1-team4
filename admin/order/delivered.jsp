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
  <title>Order Up Groceries Admin - Order Deliverd</title>
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
      <h2>Order Deliverd</h2>
    </div>

    <div class="card-body">
      <% if(request.getParameter("orderId") != null) {
          String orderId = request.getParameter("orderId");
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            String query = String.format("UPDATE `order-up-groceries`.`order` SET `status` = '%s' WHERE id = %s", "delivered", orderId);
            stmt.executeUpdate(query);
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
        }
      %>
        <div class="alert alert-primary" role="alert">
          Order Deliverd
        </div>
      <% } %>
      <a href="list.jsp" class="btn">
        <button type="button" class="btn btn-primary">Back to order list</button>
      </a>
    </div>
  </div>
  
</div>
</body>
</html>
