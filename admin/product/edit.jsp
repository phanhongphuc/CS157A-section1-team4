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
  <title>Order Up Groceries Admin - Product Edit</title>
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
      <h2>Product Edit</h2>
    </div>

    <div class="card-body">
      <% if(request.getParameter("productId") != null) {
          String productId = request.getParameter("productId");
          String productName = "";
          String price = "";
          String quantity = "";
          String image = "";
          String categoryId = "";
          String vendorId = "";
          try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
            
            Statement stmt = con.createStatement();
            
            /* get product information */
            String query = "SELECT * FROM `order-up-groceries`.product WHERE id = " + Integer.parseInt(productId);
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                productName = rs.getString("name");
                price = rs.getString("price");
                quantity = rs.getString("quantity");
                image = rs.getString("image");
            }
            
            /* get product category */
            query = String.format("SELECT * FROM `order-up-groceries`.`productInCategory` WHERE `productId` = '%s'", productId);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                categoryId = rs.getString("categoryId");
            }
            
            /* get product vendor */
            query = String.format("SELECT * FROM `order-up-groceries`.`productFromVendor` WHERE `productId` = '%s'", productId);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                vendorId = rs.getString("vendorId");
            }
            
            rs.close();
            stmt.close();
            con.close();
          } catch(SQLException e) { 
             out.println("SQLException caught: " + e.getMessage());
          }
      %>
      <%  if(request.getParameter("productName") != null) { 
            productName = request.getParameter("productName");
            price = request.getParameter("price");
            quantity = request.getParameter("quantity");
            image = request.getParameter("image");
            categoryId = request.getParameter("category");
            vendorId = request.getParameter("vendor");
            try {            
              java.sql.Connection con; 
              Class.forName("com.mysql.jdbc.Driver");
              con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
              
              Statement stmt = con.createStatement();
              
              /* update product information */
              String query = String.format("UPDATE `order-up-groceries`.product SET `name` = '%s', `price` = '%s', `quantity` = '%s', `image` = '%s' WHERE id = '%s'", productName, price, quantity, image, productId);
              stmt.executeUpdate(query);
              
              /* update productInCategory */
              query = "DELETE FROM `order-up-groceries`.`productInCategory` WHERE productId = " + Integer.parseInt(productId);
              stmt.executeUpdate(query);
              query = String.format("INSERT INTO `order-up-groceries`.`productInCategory`(`productId`, `categoryId`) VALUES ('%s', '%s')", productId, categoryId);
              stmt.executeUpdate(query);
              
              /* update productFromVendor */
              query = "DELETE FROM `order-up-groceries`.`productFromVendor` WHERE productId = " + Integer.parseInt(productId);
              stmt.executeUpdate(query);
              query = String.format("INSERT INTO `order-up-groceries`.`productFromVendor`(`productId`, `vendorId`) VALUES ('%s', '%s')", productId, vendorId);
              stmt.executeUpdate(query);
              
              stmt.close();
              con.close();
            } catch(SQLException e) { 
              out.println("SQLException caught: " + e.getMessage());
            }
      %>
        <div class="alert alert-primary" role="alert"> Product saved </div>
      <% } %>

      <form method="POST">
        <div class="form-group">
          <label for="productName">Product Name</label>
          <input type="text" class="form-control" name="productName" value="<%=productName%>" placeholder="Enter product name" required>
        </div>
        <div class="form-group">
          <label for="productName">Price</label>
          <input type="text" class="form-control" name="price" value="<%=price%>" placeholder="Enter price" required>
        </div>
        <div class="form-group">
          <label for="quantity">Quantity</label>
          <input type="text" class="form-control" name="quantity" value="<%=quantity%>" placeholder="Enter quantity" required>
        </div>
        <div class="form-group">
          <label for="image">Image</label>
          <input type="text" class="form-control" name="image" value="<%=image%>" placeholder="Enter image" required>
          <image height=100 src="<%=image%>" />
        </div>
        <div class="form-group">
            <label for="category">Product Category</label>
            <select name="category" class="form-control" id="category" required>
                <% for(int i = 0; i < categories.size(); i ++) {
                     String currentCategoryId = categories.get(i).get(0);
                     String categoryName = categories.get(i).get(1);
                     String selected = "";
                     if(currentCategoryId.equals(categoryId)) {
                         selected = "selected";
                     }
                %>
                <option value="<%=currentCategoryId%>" <%=selected%>>
                    <%=categoryName%>
                </option>
                <% } %>
            </select>
        </div>
        <div class="form-group">
            <label for="vendor">Vendor</label>
            <select name="vendor" class="form-control" id="vendor" required>
                <% for(int i = 0; i < vendors.size(); i ++) {
                     String currentVendorId = vendors.get(i).get(0);
                     String vendorName = vendors.get(i).get(1);
                     String selected = "";
                     if(currentVendorId.equals(vendorId)) {
                         selected = "selected";
                     }
                %>
                <option value="<%=currentVendorId%>" <%=selected%>>
                    <%=vendorName%>
                </option>
                <% } %>
            </select>
        </div>
        <div class="form-group">
          <button type="submit" class="btn btn-primary">Edit</button>
          <a href="list.jsp" class="btn">
            <button type="button" class="btn btn-primary">Back to product list</button>
          </a>
        </div>
      </form>
    </div>
  </div>
  <% } %>
</div>
</body>
</html>
