<%@ page import="java.sql.*"%>
<%@ page import ="java.util.ArrayList"%>

<%
String username = String.valueOf(session.getAttribute("username"));
if(session == null || username.equals("null")) {
   response.sendRedirect("login.jsp");
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
<!DOCTYPE html>
<html>
<head>
  <title>Home</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <script src="js/jquery-1.10.2.js"></script>  
  <script src="js/bootstrap.min.js"></script>
</head>
<body>
  <div class="container">
    <h1>
      Home
      <div class="float-right float-bottom h6 mt-3">
        Hi <%= username%>, <br>
        <a href="cart.jsp">Cart</a> / 
        <a href="logout.jsp">Log out</a>
      </div>
    </h1>
    <hr>
    
    <% for(int i = 0; i < categories.size(); i ++) {
         String categoryId = categories.get(i).get(0);
         String categoryName = categories.get(i).get(1);
    %>
    <div class="card mb-4 shadow-sm">
      <div class="card-header">
        <h2><%=categoryName%></h2>
      </div>
      <div class="card-body card-deck mb-3 text-center">
        <%
        /* get all products in this category */
        try {            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);

            Statement stmt = con.createStatement();
            String query = String.format("SELECT * FROM `order-up-groceries`.`product`, `order-up-groceries`.`productInCategory` WHERE `product`.`id` = `productInCategory`.`productId` AND `productInCategory`.`categoryId` = '%s'", categoryId);
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
              String productId = rs.getString("id");
              String productName = rs.getString("name");
              String price = rs.getString("price");
              String quantity = rs.getString("quantity");
              String image = rs.getString("image");
        %>
          <div class="card mb-4 shadow-sm">
            <div class="card-header">
              <h4 class="my-0 font-weight-normal"><%=productName%></h4>
            </div>
            <div class="card-body">
              <p>Price: $<%=price%></p>
              <p>In stock quantity: <%=quantity%></p>
              <p><image height=100 src="<%=image%>" /></p>
              <p>
                <a href="add.jsp?id=<%=productId%>" class="btn">
                  <button type="button" class="btn btn-lg btn-block btn-primary">Add to card</button>
                </a>
              </p>
            </div>
        </div>
        <%
            }
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
        }
        %>
      </div>
    </div>
    <% } %>
  </div>
    
</body>
</html>