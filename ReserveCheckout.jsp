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
        <h1>Reservation Carta</h1>
        <%
          Connector con = new Connector();
          if(session.getAttribute("reserveList") == null) {
            out.print("<p>Error <a href =\"BRTH.jsp\">Try again</a></p> ");
          }
          else {
            List<Reserve> reserveList = session.getAttribute("reserveList");
            out.print("<p>If everything looks good, press checkout to finalize all reservations!</p><ul>")
            for(Reserve r : reserveList) {
              out.print("<li>" + r.hid + " " + r.fromDate + " " + r.toDate + "</li>");
            }
            out.print("</ul><p><a href = \"SubmitReserves\">Checkout</a></p>);
          }
        %>
    <%
      }
    %>
  </body>
</html>