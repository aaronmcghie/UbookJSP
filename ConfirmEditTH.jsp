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
        <h1>TH Edit Confirmation</h1>
        <%
          Connector con = new Connector();
          TH ths = new TH();
          out.print(ths.changeHouse(user, con.stmt, (String)session.getAttribute("hid"), (String)request.getParameter("houseName"), (String)request.getParameter("address"), (String)request.getParameter("city"), (String)request.getParameter("state"), (String)request.getParameter("phoneNumber"), (String)request.getParameter("yearBuilt"), (String)request.getParameter("category"), (String)request.getParameter("URL")));
          con.closeStatement();
          con.closeConnection();
        %>
        <p><a href = "MainMenu.jsp">Return Home!</a></p>
    <%
      }
    %>
  </body>
</html>