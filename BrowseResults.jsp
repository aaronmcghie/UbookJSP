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
        <h1>Browse TH Results</h1>
        <p>Here are your results:</p>
        <%
          String params = (String)session.getAttribute("params");
          if (params == null) params = "";
          String minPrice = request.getParameter("minimum_price");
          if (minPrice == null) minPrice = "";
          String maxPrice = request.getParameter("maximum_price");
          if (maxPrice == null) maxPrice = "";
          String city = request.getParameter("city");
          if (city == null) city = "";
          String state = request.getParameter("state");
          if (state == null) state = "";
          String category = request.getParameter("category");
          if (category == null) category = "";
          String keywords = request.getParameter("keywords");
          if (keywords == null) keywords = "";
          String sortBy = "average score";
          Connector con = new Connector();
          BRTH browse = new BRTH();
          String result = browse.browseTHs(con.stmt, minPrice, maxPrice, city, state, category, keywords, sortBy, params);
          out.print(result);
          con.closeStatement();
          con.closeConnection();
        %>
        
        <p><a href = "MainMenu.jsp">Return to Main Menu!</a></p>
    <%
      }
    %>
  </body>
</html>