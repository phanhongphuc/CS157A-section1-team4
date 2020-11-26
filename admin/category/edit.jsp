<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries Admin - Category Edit</title>
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
  
  <div class="card mb-4 shadow-sm">
    <div class="card-header">
      <h2>Category Create</h2>
    </div>

    <div class="card-body">
      <% if(request.getParameter("categoryId") != null) {
          String categoryId = request.getParameter("categoryId");
          String categoryName = "";
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            String query = "SELECT * FROM `order-up-groceries`.category WHERE categoryId = " + Integer.parseInt(categoryId);
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                categoryName = rs.getString(2);
            }
            rs.close();
            stmt.close();
            con.close();
          } catch(SQLException e) { 
             out.println("SQLException caught: " + e.getMessage());
          }
      %>
      <%  if(request.getParameter("categoryName") != null) { 
            categoryName = request.getParameter("categoryName");
            try {            
              java.sql.Connection con; 
              Class.forName("com.mysql.jdbc.Driver");
              con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
              
              Statement stmt = con.createStatement();
              String query = "UPDATE `order-up-groceries`.category SET `name` = '" + categoryName + "' WHERE categoryId = " + Integer.parseInt(categoryId);;
              stmt.executeUpdate(query);
              stmt.close();
              con.close();
            } catch(SQLException e) { 
              out.println("SQLException caught: " + e.getMessage());
            }
      %>
        <div class="alert alert-primary" role="alert"> Category saved </div>
      <% } %>

      <form method="POST">
        <div class="form-group">
          <label for="categoryName">Category Name</label>
          <input type="text" class="form-control" name="categoryName" value="<%=categoryName%>" placeholder="Enter category name" required>
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary">Edit</button>
          <a href="list.jsp" class="btn">
            <button type="button" class="btn btn-primary">Back to category list</button>
          </a>
        </div>
      </form>
    </div>
  </div>
  <% } %>
</div>
</body>
</html>
