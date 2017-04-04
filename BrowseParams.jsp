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
        <p>Please enter each parameter</p>
        <form action = "BrowseResults.jsp" method = "post">
        <%
          String params = request.getParameter("params");
          if(params.contains("maximum_price")) {
            %>
            <p>Maximum Price:</p>
            <input type = "text" name = "maximum_price">
            <%
          }
          if(params.contains("minimum_price")) {
            %>
            <p>Minimum Price:</p>
            <input type = "text" name = "minimum_price">
            <%
          }
          if(params.contains("state")) {
            %>
            <p>State:</p>
            <input type = "text" name = "state">
            <%
          }
          if(params.contains("city")) {
            %>
            <p>City:</p>
            <input type = "text" name = "city">
            <%
          }
          if(params.contains("category")) {
            %>
            <p>Category:</p>
            <input type = "text" name = "category">
            <%
          }
          if(params.contains("keywords")) {
            %>
            <p>Keywords:</p>
            <p>Format: keyword1 keyword2 keyword3</p>
            <input type = "text" name = "keywords"><br>
            <%
          }
        %>
          <input type = "submit" value = "Submit!">
        </form>
    <%
      }
    %>
  </body>
</html>