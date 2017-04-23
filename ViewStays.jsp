<%@ page language="java" import= "Ubook.*"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
        <h1>View Stays</h1>
        <p>Welcome to View Stays.</p>
    <%
    
    	Stay stays = new Stay();
	
    if(request.getParameter("seeReserves") != null){
        Connector con = new Connector();
        List<String> checkoutPids = (List<String>)session.getAttribute("checkoutPids");
        if(checkoutPids == null) checkoutPids = new ArrayList<String>();
        out.println("Here are your reservations" + "<br>");
        out.print(stays.showReservations((String)session.getAttribute("user"), con.stmt, checkoutPids));
        con.closeStatement();
        con.closeConnection();
    }
    else if(request.getParameter("seeStays") != null){
        Connector con = new Connector();
        out.println("Here are your Stays" + "<br>");
        out.print(stays.viewStays((String)session.getAttribute("user"), con.stmt, "TH.jsp"));
        con.closeStatement();
        con.closeConnection();
    }
    
	%>
	<form action = "ViewStays.jsp" method = post>
	<input type = submit name = "seeReserves" value = "See your reserves"/><br>
	<input type = submit name = "seeStays" value = "See your stays"/><br>
	</form>
	<br>
	<a href=MainMenu.jsp>Back to main</a> 
	<%
	
	
      }
    %>
  </body>
</html>