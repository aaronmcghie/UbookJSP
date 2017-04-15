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
        <h1>Your THs</h1>
        <p>Your TH Options:</p>
        <ul>
          <li>
            <a href = "NewTH.jsp">Register a new TH</a>
          </li>
          <li>
            <a href = "ViewTHs.jsp">View/Edit your THs</a>
          </li>
          <li>
            <a href = "Keywords.jsp">View/Create Keywords on THs</a>
          </li>
          <li>
            <a href = "Avails.jsp">View/Update Availability on THs</a>
          </li>
        </ul>
        <p><a href = "MainMenu.jsp">Return Home</a></p>
    <%
      }
    %>
  </body>
</html>