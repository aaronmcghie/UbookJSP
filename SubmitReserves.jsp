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
        <h1>Reservation Cart</h1>
        <%
          Connector con = new Connector();
          if(session.getAttribute("reserveList") == null) {
            out.print("<p>Error <a href =\"BRTH.jsp\">Try again</a></p> ");
          }
          else {
            List<Reserve> reserveList = (List<Reserve>)session.getAttribute("reserveList");
            BRTH browse = new BRTH();
            for(Reserve r : reserveList) {
              browse.insertReserve(user, r, con.stmt);
            }
            session.setAttribute("reserveList", null);
            out.print("Your reservations have all been added!");
            con.closeStatement();
            con.closeConnection();
          }
          
        %>
        <p><a href = "ViewStays.jsp">View your reservations</a> or <a href = "BRTH.jsp">Back to browse and reserve</a></p>
    <%
      }
    %>
  </body>
</html>