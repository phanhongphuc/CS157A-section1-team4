<% String username = String.valueOf(session.getAttribute("username")); %>
<div class="card mb-4 shadow-sm">
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      <li class="nav-item">
        <a class="nav-link" href="../home.jsp">Home<span class="sr-only"></span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../category/list.jsp">Category<span class="sr-only"></span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../product/list.jsp">Product<span class="sr-only"></span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../vendor/list.jsp">Vendor<span class="sr-only"></span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../order/list.jsp">Order<span class="sr-only"></span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../customer/list.jsp">Customer<span class="sr-only"></span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../shipper/list.jsp">Shipper<span class="sr-only"></span></a>
      </li>
    </ul>
    Hi <%= username%>, 
    <a class="nav-link" href="../logout.jsp">Log out<span class="sr-only"></span></a>
    </div>
  </nav>
</div>