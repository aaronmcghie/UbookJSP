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
        <h1>TH Availabilities</h1>
        <p>Availabilities for selected TH</p>
        <%
          Connector con = new Connector();
          BRTH browse = new BRTH();
          out.print(browse.showTHAvails(request.getParameter("id") ,con.stmt));
          con.closeStatement();
          con.closeConnection();
        %>
    <%
      }
    %>
  </body>
</html>