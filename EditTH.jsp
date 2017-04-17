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
              session.setAttribute("hid", request.getParameter("id"));
    %>
        <h1>Edit TH</h1>
        <form action = "ConfirmEditTH.jsp" method = "post">
          <p>House Name: <input type = "text" name = "houseName"></p>
          <p>Address: <input type = "text" name = "address"></p>
          <p>City: <input type = "text" name = "city"></p>
          <p>State: <input type = "text" name = "state"></p>
          <p>Phone Number: <input type = "text" name = "phoneNumber"></p>
          <p>Year Built: <input type = "number" name = "yearBuilt" min = "1800" max = "2100"></p>
          <p>Category: <input type = "text" name = "category"></p>
          <p>URL: <input type = "url" name = "URL"></p>
          <p><input type = "submit" value = "Submit!"></p>
        </form>
    <%
      }
    %>
  </body>
</html>