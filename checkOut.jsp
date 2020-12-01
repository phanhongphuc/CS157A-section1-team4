<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>

<%
/* check if the user has logined */
String name = String.valueOf(session.getAttribute("username"));
if(session == null || name.equals("null")) {
   response.sendRedirect("login.jsp");
}
%>

<%
/* save order information to database */
int orderId = 0;
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
LocalDateTime now = LocalDateTime.now();  
String date = dtf.format(now);
String total = request.getParameter("total");
String address = request.getParameter("address");
String creditName = request.getParameter("name");
String creditNumber = request.getParameter("credit");
String expiredDate = request.getParameter("expired");

String db = "cs157a";
String user = "root";
String password = "root";
try {            
  Class.forName("com.mysql.jdbc.Driver");
  java.sql.Connection con; 
  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
  
  Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
  /* Insert information into table product */
  String query = String.format("INSERT INTO `order-up-groceries`.`order`(`date`, `total`, `address`, `name`, `credit`, `expired`, `status`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s')", date, total, address, creditName, creditNumber, expiredDate, "delivering");
  stmt.executeUpdate(query);
  
  /* Find the last insert Id */
  query = ("SELECT * FROM `order-up-groceries`.`order`");
  ResultSet rs = stmt.executeQuery(query);
  if(rs.last()){
      orderId = rs.getInt("id");
  }
  
  stmt.close();
  con.close();
} catch(SQLException e) { 
  out.println("SQLException caught: " + e.getMessage());
} 
%>

<%
/* prepare the hash map of productId -> quantity */
String cart = "''";
HashMap<Integer, Integer> mapCart = new HashMap<Integer, Integer>();
if(session.getAttribute("cart") != null){
  cart = String.valueOf(session.getAttribute("cart"));
  String[] arrayCart = cart.split(",");

  for(String productId:arrayCart) {
    int id = Integer.parseInt(productId);
    if (mapCart.containsKey(id)) {
      mapCart.put(id, mapCart.get(id) + 1);
    } else {
      mapCart.put(id, 1);
    }
  }
}
%>

<%
/* save list of products in the order to table productInOrder */
try {
  java.sql.Connection con; 
  Class.forName("com.mysql.jdbc.Driver");
  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
  
  Statement stmt = con.createStatement();
  String query = String.format("SELECT * FROM `order-up-groceries`.product WHERE `id` IN (%s)", cart);
  ResultSet rs = stmt.executeQuery(query);
  while (rs.next()) {
    int productId = rs.getInt("id");
    String productName = rs.getString("name");
    int unitPrice = rs.getInt("price");
    int quantity = mapCart.get(productId);
    query = String.format("INSERT INTO `order-up-groceries`.`productInOrder`(`productId`, `orderId`, `quantity`, `price`) VALUES ('%s', '%s', '%s', '%s')", productId, orderId, quantity, unitPrice);
    stmt = con.createStatement();
    stmt.executeUpdate(query);
  }
  rs.close();
  stmt.close();
  con.close();
} catch(SQLException e) { 
  out.println("SQLException caught: " + e.getMessage());
}
%>

<%
/* save data to table customerPlaceOrder */
String userId = String.valueOf(session.getAttribute("userId"));
try {
  java.sql.Connection con; 
  Class.forName("com.mysql.jdbc.Driver");
  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
  
  Statement stmt = con.createStatement();
  String query = String.format("INSERT INTO `order-up-groceries`.`customerPlaceOrder`(`customerId`, `orderId`) VALUES ('%s', '%s')", userId, orderId);
  stmt.executeUpdate(query);
  stmt.close();
  con.close();
} catch(SQLException e) { 
  out.println("SQLException caught: " + e.getMessage());
}
request.getSession().setAttribute("cart", null);
%>



<!DOCTYPE html>
<html>
<head>
  <title>Order Up Groceries - Check out</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <script src="js/jquery-1.10.2.js"></script>
  <script src="js/bootstrap.min.js"></script>
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
      <h2>
        Check out
        <div class="float-right float-bottom h6 mt-3">
          Hi <%= name %>, <br> 
          <a href="logout.jsp">Log out</a>
        </div>
      </h2>
      <hr>
        <a href="home.jsp" class="btn">
          <button type="button" class="btn btn-primary">Back to Homepage</button>
        </a>
    </div>

    <div class="card-body">
      <div class="alert alert-primary" role="alert">
        Checked out
      </div>
    </div>
  </div>

</div>
</body>
</html>
