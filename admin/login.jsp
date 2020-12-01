<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <title>Log In</title>
  <link rel="stylesheet" href="../css/bootstrap.min.css">
  <script src="../js/jquery-1.10.2.js"></script>  
  <script src="../js/bootstrap.min.js"></script>
</head>
<body class="text-center">
  <div class="container">
    <form class="form-signin">
        <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input name="username" type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input name="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>
    <% if(request.getParameter("username") != null) {
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
            String query = String.format("SELECT * FROM `order-up-groceries`.`user` WHERE username='%s' AND password='%s'", un, pw);
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
              request.getSession().setAttribute("userId", rs.getString("id"));
              request.getSession().setAttribute("username", rs.getString("username"));
              request.getSession().setAttribute("userRole", rs.getString("role"));
              response.sendRedirect("home.jsp");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage());
        }
      %>
        <div class="alert alert-danger" role="alert">
          Invalid username or password.
        </div>
      <% } %>
  </div>
</body>
</html>