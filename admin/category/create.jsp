<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries Admin - Category Create</title>
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
      <% if(request.getParameter("categoryName") != null) {
          String categoryName = request.getParameter("categoryName");
          String db = "cs157a";
          String user = "root";
          String password = "root";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            String query = "INSERT INTO `order-up-groceries`.category(`name`) VALUES (\"" + categoryName + "\")";
            stmt.executeUpdate(query);
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
        }
      %>
        <div class="alert alert-primary" role="alert">
          Category saved
        </div>
      <% } %>
      <form method="POST">
        <div class="form-group">
          <label for="categoryName">Category Name</label>
          <input type="text" class="form-control" name="categoryName" placeholder="Enter category name" required>
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary">Create</button>
          <a href="list.jsp" class="btn">
            <button type="button" class="btn btn-primary">Back to category list</button>
          </a>
        </div>
      </form>
    </div>
  </div>
  
</div>
</body>
</html>
