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
  <title>Order Up Groceries Admin - Vendor Delete</title>
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
      <h2>Vendor Delete</h2>
    </div>

    <div class="card-body">
      <% if(request.getParameter("vendorId") != null) {
          String vendorId = request.getParameter("vendorId");
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            String query = "DELETE FROM `order-up-groceries`.`vendor` WHERE (`vendorId` = '" + vendorId + "')";
            stmt.executeUpdate(query);
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
        }
      %>
        <div class="alert alert-primary" role="alert">
          Vendor deleted
        </div>
      <% } %>
      <a href="list.jsp" class="btn">
        <button type="button" class="btn btn-primary">Back to vendor list</button>
      </a>
    </div>
  </div>
  
</div>
</body>
</html>
