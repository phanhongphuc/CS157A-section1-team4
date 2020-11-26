<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries Admin - Category List</title>
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
      <h2>Category List</h2>
      <hr>
      <a href="create.jsp" class="btn">
        <button type="button" class="btn btn-primary">Category Create</button>
      </a>
       <a href="../home.jsp" class="btn">
        <button type="button" class="btn btn-primary">Back to Homepage</button>
      </a>
    </div>

    <div class="card-body">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <td>Id</td>
            <td>Name</td>
            <td>Action</td>
          </tr>
        <thead>
        <tbody>
      <%
          String categoryName = request.getParameter("categoryName");
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM `order-up-groceries`.category");
            while (rs.next()) {
      %>
              <tr>
                <td> <%= rs.getInt(1) %></td>
                <td> <%= rs.getString(2) %></td>
                <td>
                  <a href="delete.jsp?categoryId=<%= rs.getInt(1) %>" class="btn confirmation">
                    <button type="button" class="btn btn-primary">Delete</button>
                  </a>
                  <a href="edit.jsp?categoryId=<%= rs.getInt(1) %>" class="btn">
                    <button type="button" class="btn btn-primary">Edit</button>
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
  <script type="text/javascript">
    $('.confirmation').on('click', function () {
        return confirm('Are you sure to delete the category?');
    });
  </script>
</body>
</html>
