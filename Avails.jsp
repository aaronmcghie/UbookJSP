<%@ page language="java" import= "Ubook.*"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Availabilities</title>
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
        <h1>Availability</h1>
        <p>Welcome to the availability menu</p>
    <%
    
    	dateInfo dates = new dateInfo();
    	
    	if(request.getParameter("seeAvailabilities") != null){
   			%>
  		    <form action = "Avails.jsp" method=post>
  			House ID:<input type = "text" name = "THID" value = "0"/><br>
  			<input type = "submit" name="updateSeeAvailability" value="view results"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updateSeeAvailability") != null){
   			Connector con = new Connector();
    		List<Period> results = dates.showAvailability((String)request.getParameter("THID"), con.stmt);  		
			
    		for(int i = 0; i < results.size(); i++)
			{
				Period current = results.get(i);
				out.println("======================================================================================================" + "<br>");
				out.println("Availability #"+ Integer.toString(i+1) + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Availiability ID: " + current.getPID() + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Availability: " + current.getFrom()+  " to "+ current.getTo() +"<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Price per night: " + current.getPrice() + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("<br>");
			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	else if(request.getParameter("changeAvailability") != null){
   			%>
  		    <form action = "Avails.jsp" method=post>
  			House ID:<input type = "text" name = "THID" value = "0"/><br>
  			Availability ID:<input type = "text" name = "PID" value = "0"/><br>
  			From Date: <input type = "text" name = "from" value = "2017-06-01"/><br>
  			To Date: <input type = "text" name = "to" value = "2017-06-01"/><br>
  			Price: <input type = "text" name = "price" value = "0"/><br>
  			<input type = "submit" name="updateChangeAvailability" value="Submit"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updateChangeAvailability") != null){
   			Connector con = new Connector();
   			if(dates.createChangeAvailability((String)request.getParameter("THID"), con.stmt, (String)request.getParameter("PID"), (String)request.getParameter("from"), (String)request.getParameter("to"), (String)request.getParameter("price"))){
   				out.println("The availability was successfully changed!");
   			}
   			else{
   				out.println("There was an issue with your selection.  The availability was not changed.");
   				
   			}
   			
   			
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	else if(request.getParameter("addAvailability") != null){
   			%>
  		    <form action = "Avails.jsp" method=post>
  			House ID:<input type = "text" name = "THID" value = "0"/><br>
  			From Date: <input type = "text" name = "from" value = "2017-06-01"/><br>
  			To Date: <input type = "text" name = "to" value = "2017-06-01"/><br>
  			Price: <input type = "text" name = "price" value = "0"/><br>
  			<input type = "submit" name="updateAddAvailability" value="Submit"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updateAddAvailability") != null){
   			Connector con = new Connector();
			
    		if(dates.createAvailability((String)request.getParameter("THID"), con.stmt, (String)request.getParameter("from"), (String)request.getParameter("to"), (String)request.getParameter("price"))){
   				out.println("The availability was successfully added!");
   			}
   			else{
   				out.println("There was an issue with your selection.  The availability was not added.");
   				
   			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	else if(request.getParameter("removeAvailability") != null){
   			%>
  		    <form action = "Avails.jsp" method=post>
  			House ID:<input type = "text" name = "THID" value = "0"/><br>
  			Availability ID:<input type = "text" name = "PID" value = "0"/><br>
  			<input type = "submit" name="updateRemoveAvailability" value="Submit"/><br>
  			</form>
  		    <%
    	}
    	
    	
    	else if(request.getParameter("updateRemoveAvailability") != null){
   			Connector con = new Connector();
			
    		if(dates.removeAvailability((String)request.getParameter("THID"), con.stmt, (String)request.getParameter("PID"))){
   				out.println("The availability was successfully removed!");
   			}
   			else{
   				out.println("There was an issue with your selection.  The availability was not removed.");
   				
   			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	
    	%>
    <br>
   	<form action = "Avails.jsp" method = post>
	<input type = submit name = "seeAvailabilities" value = "See the availabilities of a house"/><br>
	<input type = submit name = "changeAvailability" value = "Change an existing availability"/><br>
	<input type = submit name = "addAvailability" value = "Add a new availability"/><br>
	<input type = submit name = "removeAvailability" value = "Remove a availability"/><br>
	</form>
	<br>
	<a href=MainMenu.jsp>Back to main</a> 
    	<%
    	
      }
    %>
</body>
</html>