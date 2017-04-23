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
        <p>Your Stay Cart</p>
        <p>Review your cart and press checkout to record your stay.</p>
        <%
          Connector con = new Connector();
          Stay stays = new Stay();
          List<String> checkoutPids = (List<String>)session.getAttribute("checkoutPids");
          if(checkoutPids == null) out.print("<p>Your cart is empty.  <a href = \"RecordStay.jsp\">Start over!</a></p>");
          else {
            out.print(stays.printSelected(user, con.stmt, checkoutPids));
            out.print("<p><a href = \"StayCheckout.jsp\">Checkout!</a> or <a href = \"MainMenu.jsp\">Home</a></p>");
          }
          con.closeStatement();
          con.closeConnection();
        %>
    <%
      }
    %>
  </body>
</html>