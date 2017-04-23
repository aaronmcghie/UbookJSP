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
        <h1>TH Availabilities</h1>
        <p>Availabilities for selected TH</p>
        <%
          Connector con = new Connector();
          BRTH browse = new BRTH();
          out.print(browse.showTHAvails(request.getParameter("id") ,con.stmt));
          con.closeStatement();
          con.closeConnection();
          if(session.getAttribute("reserveList") == null) {
            session.setAttribute("reserveList", new ArrayList<Reserve>());
          }
          session.setAttribute("hid", request.getParameter("id"));
        %>
        <form action = "ConfirmReserve.jsp" method = "post">
          <p>Start Date:</p><input type = "date" name = "fromDate">
          <p>End Date:</p><input type = "date" name = "toDate">
          <input type = "submit" name = "submitReserve" value = "submit">
          <br>
          <p><a href=MainMenu.jsp>Back to main</a> - <a href = "ReserveTH.jsp">Back to TH List</a> - <a href = "ReserveCheckout.jsp">Checkout!</a></p>
        </form>
    <%
      }
    %>
  </body>
</html>