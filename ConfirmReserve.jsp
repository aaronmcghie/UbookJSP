<%@ page language="java" import= "Ubook.*"%>
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
        <h1>Reservation Added To Cart!</h1>
        <%
          Connector con = new Connector();
          con.closeStatement();
          con.closeConnection();
          if(session.getAttribute("reserveList") == null) {
            out.print("<p>Error <a href =\"BRTH.jsp\">Try again</a></p> ");
          }
          else {
            List reserveList = session.getAttribute("reserveList");
            reserveList.Add(new Reserve(session.getAttribute("hid"), request.getAttribute("fromDate"), request.getAttribute("toDate")));
            out.print("<p>Reservation added to your Reservation Cart!</p>");
            out.print("<p><a href = \"ReserveTH.jsp\">Make another Reservation</a> or <a href = "ReserveCheckout.jsp">Checkout!</a></p>");
          }
        %>
    <%
      }
    %>
  </body>
</html>