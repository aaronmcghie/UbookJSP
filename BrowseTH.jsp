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
        <h1>Browse THs</h1>
        <p>Welcome to browse THs.</p>
        <form action = "BrowseParams.jsp" method = "post">
          <p>Input your parameters:</p>
          <input type = "text" name = "params">
          <p>Format Example: 'minimum_price and city or state'</p>
          <p>Options: minimum_price, maximum_price, city, state, category, keywords</p>
          <input type = "submit" value = "Submit!">
        </form>
    <%
      }
    %>
  </body>
</html>