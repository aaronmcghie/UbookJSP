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
        <h1>Record Stays</h1>
        <p>Welcome to Record Stays.</p>
        <p>Here is a list of all your reservations, click one to record a stay there</p>
        <%
          Connector con = new Connector();
          Stay stays = new Stay();
          List<String> checkoutPids = (List<String>)session.getAttribute("checkoutPids");
          if(checkoutPids == null) checkoutPids = new ArrayList<String>();
          out.print(stays.showReservations(user, con.stmt, checkoutPids));
          con.closeStatement();
          con.closeConnection();
        %>
        <p><a href = "StayCart.jsp">Checkout!</a> or <a href = "MainMenu.jsp">Home</a></p>
    <%
      }
    %>
  </body>
</html>