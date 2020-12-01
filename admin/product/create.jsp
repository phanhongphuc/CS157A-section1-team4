<%@ page import="java.sql.*"%>
<%@ page import ="java.util.ArrayList"%>

<%
String name = String.valueOf(session.getAttribute("username"));
String role = String.valueOf(session.getAttribute("userRole"));
if(session == null || name == null || !role.equals("admin")) {
   response.sendRedirect("../login.jsp");
}
%>

<%
/* get all categories */
String db = "cs157a";
String user = "root";
String password = "root";
ArrayList <ArrayList<String>> categories = new ArrayList();
try {            
    java.sql.Connection con; 
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);

    Statement stmt = con.createStatement();
    String query = "SELECT * FROM `order-up-groceries`.category";
    ResultSet rs = stmt.executeQuery(query);
    while (rs.next()) {
        ArrayList<String> item = new ArrayList();
        item.add(rs.getString("categoryId"));
        item.add(rs.getString("name"));
        categories.add(item);
    }
} catch(SQLException e) { 
    out.println("SQLException caught: " + e.getMessage());
}
%>

<%
/* get all vendors */
ArrayList <ArrayList<String>> vendors = new ArrayList();
try {            
    java.sql.Connection con; 
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);

    Statement stmt = con.createStatement();
    String query = "SELECT * FROM `order-up-groceries`.`vendor`";
    ResultSet rs = stmt.executeQuery(query);
    while (rs.next()) {
        ArrayList<String> item = new ArrayList();
        item.add(rs.getString("id"));
        item.add(rs.getString("name"));
        vendors.add(item);
    }
} catch(SQLException e) { 
    out.println("SQLException caught: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries Admin - Product Create</title>
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
      <h2>Product Create</h2>
    </div>

    <div class="card-body">
      <% if(request.getParameter("productName") != null) {
          String productName = request.getParameter("productName");
          String price = request.getParameter("price");
          String quantity = request.getParameter("quantity");
          String image = request.getParameter("image");
          String categoryId = request.getParameter("category");
          String vendorId= request.getParameter("vendor");
          try {            
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection con; 
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
            /* Insert information into table product */
            String query = String.format("INSERT INTO `order-up-groceries`.product(`name`, `price`, `quantity`, `image`) VALUES ('%s', '%s', '%s', '%s')", productName, price, quantity, image);
            stmt.executeUpdate(query);
            
            /* Find the last insert Id */
            int productId = 0;
            query = ("SELECT * FROM `order-up-groceries`.`product`");
            ResultSet rs = stmt.executeQuery(query);
            if(rs.last()){
                productId = rs.getInt("id");
            }
            
            /* Insert information into table productInCategoty */
            query = String.format("INSERT INTO `order-up-groceries`.`productInCategory`(`productId`, `categoryId`) VALUES ('%s', '%s')", productId, categoryId);
            stmt.executeUpdate(query);
            
            /* Insert information into table productFromVendor */
            query = String.format("INSERT INTO `order-up-groceries`.`productFromVendor`(`productId`, `vendorId`) VALUES ('%s', '%s')", productId, vendorId);
            stmt.executeUpdate(query);
            
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
        }
      %>
        <div class="alert alert-primary" role="alert">
          Product saved
        </div>
      <% } %>
      <form method="POST">
        <div class="form-group">
          <label for="productName">Product Name</label>
          <input type="text" class="form-control" name="productName" placeholder="Enter product name" required>
        </div>
        <div class="form-group">
          <label for="price">Price</label>
          <input type="text" class="form-control" name="price" placeholder="Enter price" required>
        </div>
        <div class="form-group">
          <label for="quantity">Quantity</label>
          <input type="text" class="form-control" name="quantity" placeholder="Enter quantity" required>
        </div>
        <div class="form-group">
          <label for="quantity">Image</label>
          <input type="text" class="form-control" name="image" placeholder="Enter image" required>
        </div>
        <div class="form-group">
            <label for="category">Product Category</label>
            <select name="category" class="form-control" id="category" required>
                <% for(int i = 0; i < categories.size(); i ++) { %>
                <option value="<%=categories.get(i).get(0)%>">
                    <%=categories.get(i).get(1)%>
                </option>
                <% } %>
            </select>
        </div>
        <div class="form-group">
            <label for="vendor">Vendor</label>
            <select name="vendor" class="form-control" id="vendor" required>
                <% for(int i = 0; i < vendors.size(); i ++) { %>
                <option value="<%=vendors.get(i).get(0)%>">
                    <%=vendors.get(i).get(1)%>
                </option>
                <% } %>
            </select>
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary">Create</button>
          <a href="list.jsp" class="btn">
            <button type="button" class="btn btn-primary">Back to product list</button>
          </a>
        </div>
      </form>
    </div>
  </div>
  
</div>
</body>
</html>
