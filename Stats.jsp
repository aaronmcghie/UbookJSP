<%@ page language="java" import= "Ubook.*"%>
<%@ page import="java.util.List" %>
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
        <h1>Statistics</h1>
        <p>Welcome to Create and View Statistics</p>
    <%
    
    	Stats viewStats = new Stats();
    	
    	if(request.getParameter("seePopHouses") != null){
   			%>
  		    <form action = "Stats.jsp" method=post>
  			Number of most popular houses:<input type = "text" name = "amountPopTH" value = "0"/><br>
  			<input type = "submit" name="updatePopHouses" value="view results"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updatePopHouses") != null){
   			Connector con = new Connector();
    		List<HouseInfo> results = viewStats.popularTH(request.getParameter("amountPopTH"), con.stmt);  		
			
    		for(int i = 0; i < results.size(); i++)
			{
				HouseInfo current = results.get(i);
				out.println("======================================================================================================" + "<br>");
				out.println("House #"+ Integer.toString(i+1) + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("HouseID: " + current.getID()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Visits: " + current.getCount()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Name: " + current.getName()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH category: " + current.getCategory()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH address: " + current.getAddress()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH URL: " + current.getURL()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Phone Number: " + current.getNumber()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Year Built: " + current.getYear()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH City: " + current.getCity()+  " TH State: " +current.getState()+"<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Owner: " + current.getOwner()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("<br>");
			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	else if(request.getParameter("seeExpensiveHouses") != null){
   			%>
  		    <form action = "Stats.jsp" method=post>
  			Number of most popular houses:<input type = "text" name = "amountExpTH" value = "0"/><br>
  			<input type = "submit" name="updateExpensiveHouses" value="view results"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updateExpensiveHouses") != null){
   			Connector con = new Connector();
    		List<HouseInfo> results = viewStats.expensiveTH(request.getParameter("amountExpTH"), con.stmt);  		
			
    		for(int i = 0; i < results.size(); i++)
			{
				HouseInfo current = results.get(i);
				out.println("======================================================================================================" + "<br>");
				out.println("House #"+ Integer.toString(i+1) + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("HouseID: " + current.getID()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH average cost: " + current.getCount()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Name: " + current.getName()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH category: " + current.getCategory()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH address: " + current.getAddress()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH URL: " + current.getURL()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Phone Number: " + current.getNumber()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Year Built: " + current.getYear()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH City: " + current.getCity()+  " TH State: " +current.getState()+"<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Owner: " + current.getOwner()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("<br>");
			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	else if(request.getParameter("seePopCat") != null){
   			%>
  		    <form action = "Stats.jsp" method=post>
  			Number of most popular houses:<input type = "text" name = "amountPopCat" value = "0"/><br>
  			<input type = "submit" name="updatePopCat" value="view results"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updatePopCat") != null){
   			Connector con = new Connector();
    		List<HouseInfo> results = viewStats.ratedTH(request.getParameter("amountPopCat"), con.stmt);  		
			
    		for(int i = 0; i < results.size(); i++)
			{
				HouseInfo current = results.get(i);
				out.println("======================================================================================================" + "<br>");
				out.println("House #"+ Integer.toString(i+1) + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("HouseID: " + current.getID()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Ratings: " + current.getCount()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Name: " + current.getName()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH category: " + current.getCategory()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH address: " + current.getAddress()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH URL: " + current.getURL()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Phone Number: " + current.getNumber()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Year Built: " + current.getYear()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH City: " + current.getCity()+  " TH State: " +current.getState()+"<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH Owner: " + current.getOwner()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("<br>");
			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	
    	%>
   	<form action = "Stats.jsp" method = post>
	<input type = submit name = "seePopHouses" value = "See The most popular houses"/><br>
	<input type = submit name = "seeExpensiveHouses" value = "See the most expensive houses, by average cost"/><br>
	<input type = submit name = "seePopCat" value = "See the top rated houses by category"/><br>
	</form>
	<br>
	<a href=MainMenu.jsp>Back to main</a> 
    	<%
    	
      }
    %>
  </body>
</html>