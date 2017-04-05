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
          String params = session.getAttribute("params");
          String minPrice = request.getParameter("min_price");
          String maxPrice = request.getParameter("max_price");
          String city = request.getParameter("city");
          String state = request.getParameter("state");
          String category = request.getParameter("category");
          String keywords = request.getParameter("keywords");
          String sortBy = "price";
          Connector con = new Connector();
          BRTH browse = new BRTH();
          String result = browse.browseTHs(con.stmt, minPrice, maxPrice, city, state, category, keywords, sortBY, params);
          ouit.println(result);
        %>
        
        <p><a href = "MainMenu.jsp">Return to Main Menu!</a></p>
    <%
      }
    %>
  </body>
</html>