<%
String username = String.valueOf(session.getAttribute("username"));
String userRole = String.valueOf(session.getAttribute("userRole"));
if(session == null || username == null || !userRole.equals("admin")) {
   response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
  <title>Home</title>
  <link rel="stylesheet" href="../css/bootstrap.min.css">
  <script src="../js/jquery-1.10.2.js"></script>  
  <script src="../js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>
          Home
          <div class="float-right float-bottom h6 mt-3">
            Hi <%= username%>, <br>
            <a href="logout.jsp">Log out</a>
          </div>
        </h1>
        <hr>
        <div class="container">
          <div class="card-deck mb-3 text-center">
            <div class="card mb-4 shadow-sm">
              <div class="card-header">
                <h4 class="my-0 font-weight-normal">Category</h4>
              </div>
              <div class="card-body">
                <a href="category/list.jsp" class="btn">
                    <button type="button" class="btn btn-lg btn-block btn-primary">Enter</button>
                </a>
              </div>
            </div>
            
            <div class="card mb-4 shadow-sm">
              <div class="card-header">
                <h4 class="my-0 font-weight-normal">Product</h4>
              </div>
              <div class="card-body">
                <a href="product/list.jsp" class="btn">
                    <button type="button" class="btn btn-lg btn-block btn-primary">Enter</button>
                </a>
              </div>
            </div>
            
            <div class="card mb-4 shadow-sm">
              <div class="card-header">
                <h4 class="my-0 font-weight-normal">Vendor</h4>
              </div>
              <div class="card-body">
                <a href="vendor/list.jsp" class="btn">
                    <button type="button" class="btn btn-lg btn-block btn-primary">Enter</button>
                </a>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="card-deck mb-3 text-center">
            <div class="card mb-4 shadow-sm">
              <div class="card-header">
                <h4 class="my-0 font-weight-normal">Order</h4>
              </div>
              <div class="card-body">
                <a href="order/list.jsp" class="btn">
                    <button type="button" class="btn btn-lg btn-block btn-primary">Enter</button>
                </a>
              </div>
            </div>
            
            <div class="card mb-4 shadow-sm">
              <div class="card-header">
                <h4 class="my-0 font-weight-normal">Customer</h4>
              </div>
              <div class="card-body">
                <a href="customer/list.jsp" class="btn">
                    <button type="button" class="btn btn-lg btn-block btn-primary">Enter</button>
                </a>
              </div>
            </div>
            
            <div class="card mb-4 shadow-sm">
              <div class="card-header">
                <h4 class="my-0 font-weight-normal">Shipper</h4>
              </div>
              <div class="card-body">
                <a href="shipper/list.jsp" class="btn">
                    <button type="button" class="btn btn-lg btn-block btn-primary">Enter</button>
                </a>
              </div>
            </div>
          </div>
        </div>
    </div>
    
</body>
</html>