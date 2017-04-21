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
        <h1>Browse and Reserve THs</h1>
        <p>Welcome to browse and reserve THs.</p>
        <p>Here are your options</p>
        <ul>
          <li>
            <a href = "BrowseTH.jsp">Browse THs</a>
          </li>
          <li>
            <a href = "ReserveTH.jsp">Reserve THs</a>
          </li>
        </ul>
        
        <a href=MainMenu.jsp>Back to main</a>
    <%
      }
    %>
  </body>
</html>