<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <script src="js/jquery-1.10.2.js"></script>  
  <script src="js/bootstrap.min.js"></script>
</head>
<body class="text-center">
  <div class="container">
    <form class="form-signin">
        <h1 class="h3 mb-3 font-weight-normal">
        Please Register
        </h1>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input name="username" type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input name="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Register</button>
    </form>
    <% 
    if(request.getParameter("username") != null) {
      int userId = 0;
      String un = request.getParameter("username");
      String pw = request.getParameter("password");
      String db = "cs157a";
      String user = "root";
      String password = "root";
      try {            
        java.sql.Connection con; 
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs157a?serverTimezone=EST5EDT",user, password);
        
        Statement stmt = con.createStatement();
        String query = String.format("INSERT INTO `order-up-groceries`.user(`username`, `password`, `role`) VALUES ('%s', '%s', 'customer')", un, pw);
        int insertResult = stmt.executeUpdate(query);
        if (insertResult > 0) {
          request.getSession().setAttribute("username", un);
          request.getSession().setAttribute("userRole", "customer");
          
          /* Find the last insert Id */
          query = ("SELECT * FROM `order-up-groceries`.`user`");
          stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
          ResultSet rs = stmt.executeQuery(query);
          if(rs.last()){
              userId = rs.getInt("id");
          }
          request.getSession().setAttribute("userId", userId);
          
          response.sendRedirect("home.jsp");
        }
        
        stmt.close();
        con.close();
    } catch(SQLException e) { 
         out.println("SQLException caught: " + e.getMessage());
    }
    %>
    <div class="alert alert-danger" role="alert">
      The email has been used, please try another one.
    </div>
  <% } %>
  </div>
</body>
</html>