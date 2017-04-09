<%@ page language="java" import= "Ubook.*"%>
<%@ page import = "java.util.*" %>
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
        <h1>Complete!</h1>
        <%
          Connector con = new Connector();
          Stay stays = new Stay();
          List<String> checkoutPids = (List<String>)session.getAttribute("checkoutPids");
          if(checkoutPids == null) out.print("<p>Your cart was empty!  <a href = \"RecordStay.jsp\">Start over!</a></p>");
          else {
            for(String pid : checkoutPids) {
              stays.recordStay(user, con.stmt, pid);
            }
            out.print("<p>Your stays were recorded!</p>");
            out.print("<a href = \"MainMenu.jsp\">Home</a></p>");
          }
          con.closeStatement();
          con.closeConnection();
          session.setAttribute("checkoutPids", null);
        %>
    <%
      }
    %>
  </body>
</html>