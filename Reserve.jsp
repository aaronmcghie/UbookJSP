<%@ page language="java" import= "Ubook.*"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>

  </head>
  <body>
    <%
      String user = (String)session.getAttribute("user");
      if(user == null){
    %>
        <p>You are not logged in! <a href = "MainMenu.jsp">Log in!</a></p>
    
    <%
      }
      else {
    %>
        <h1>View Reserves</h1>
        <p>Welcome to View Reserves.</p>
        
        <% 
	         Connector con = new Connector();
	         Stay viewReserves = new Stay();
	         List<String> checkoutPids = (List<String>)session.getAttribute("checkoutPids");
	          if(checkoutPids == null) checkoutPids = new ArrayList<String>();
	         out.print(viewReserves.showReservations(request.getParameter("user") ,con.stmt, checkoutPids));
	         con.closeStatement();
	         con.closeConnection();
          %>
          <p><a href = "ReserveCheckout.jsp">Checkout!</a> or <a href = "MainMenu.jsp">Home</a></p>
    <%
      }
    %>
  </body>
</html>