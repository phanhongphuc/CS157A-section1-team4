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
  <title>Order Up Groceries Admin - Vendor Create</title>
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
      <h2>Vendor Create</h2>
    </div>

    <div class="card-body">
      <% if(request.getParameter("vendorName") != null) {
          String vendorName = request.getParameter("vendorName");
          String phoneNumber = request.getParameter("phoneNumber");
          String address = request.getParameter("address");
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            String query = String.format("INSERT INTO `order-up-groceries`.vendor(`name`, `phone`, `address`) VALUES ('%s', '%s', '%s')", vendorName, phoneNumber, address);
            stmt.executeUpdate(query);
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
        }
      %>
        <div class="alert alert-primary" role="alert">
          Vendor saved
        </div>
      <% } %>
      <form method="POST">
        <div class="form-group">
          <label for="vendorName">Vendor Name</label>
          <input type="text" class="form-control" name="vendorName" placeholder="Enter vendor name" required>
        </div>
        <div class="form-group">
          <label for="phone">Phone number</label>
          <input type="text" class="form-control" name="phoneNumber" placeholder="Enter phone number" required>
        </div>
        <div class="form-group">
          <label for="address">Address</label>
          <input type="text" class="form-control" name="address" placeholder="Enter address" required>
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary">Create</button>
          <a href="list.jsp" class="btn">
            <button type="button" class="btn btn-primary">Back to vendor list</button>
          </a>
        </div>
      </form>
    </div>
  </div>
  
</div>
</body>
</html>
