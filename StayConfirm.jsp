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
        <h1>Stay Added!</h1>
        <p>A stay for your chosen reservation has been added to your Stays cart!</p>
        <%
          String pid = (String)request.getParameter("id");
          Connector con = new Connector();
          Stay stays = new Stay();
          List<String> checkoutPids = (List<String>)session.getAttribute("checkoutPids");
          if(checkoutPids == null) checkoutPids = new ArrayList<String>();
          checkoutPids.add(pid);
          session.setAttribute("checkoutPids", checkoutPids);
          con.closeStatement();
          con.closeConnection();
        %>
        <p><a href = "RecordStay.jsp">Add more stays to cart!</a> or <a href = "StayCart.jsp">Checkout</a></p>
    <%
      }
    %>
  </body>
</html>