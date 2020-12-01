<%
request.getSession().setAttribute("userId", null);
request.getSession().setAttribute("username", null);
request.getSession().setAttribute("cart", null);
request.getSession().setAttribute("userRole", null);
response.sendRedirect("login.jsp");
%>