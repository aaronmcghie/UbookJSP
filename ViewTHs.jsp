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
        <h1>View/Edit Your THs</h1>
        <p>Your THs:</p>
          <%
          Connector con = new Connector();
          TH ths = new TH();
          out.print(ths.listOwnedHouses(user, con.stmt));
          con.closeStatement();
          con.closeConnection();
        %>
        <p><a href = "MainMenu.jsp">Return Home</a></p>
    <%
      }
    %>
  </body>
</html>