<%@ page language="java" import= "Ubook.*"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Keywords</title>
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
        <h1>Keywords</h1>
        <p>Welcome to the keywords menu</p>
    <%
    
    	Keyword key = new Keyword();
    	
    	if(request.getParameter("seeKeywords") != null){
   			%>
  		    <form action = "Keywords.jsp" method=post>
  			House ID:<input type = "text" name = "THID" value = "0"/><br>
  			<input type = "submit" name="updateSeeKeywords" value="view results"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updateSeeKeywords") != null){
   			Connector con = new Connector();
    		List<Keys> results = key.viewKeyWords((String)request.getParameter("THID"), con.stmt);  		
			
    		for(int i = 0; i < results.size(); i++)
			{
				Keys current = results.get(i);
				out.println("======================================================================================================" + "<br>");
				out.println("Keyword #"+ Integer.toString(i+1) + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("HouseID: " + (String)request.getParameter("THID")+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Keyword ID: " + current.getWid()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Keyword: " + current.getWord()+ "   ==== Keyword language: " +current.getLanguage() + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("<br>");
			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	else if(request.getParameter("removeKeywords") != null){
   			%>
  		    <form action = "Keywords.jsp" method=post>
  			House ID:<input type = "text" name = "THID" value = "0"/><br>
  			Keyword ID:<input type = "text" name = "WID" value = "0"/><br>
  			<input type = "submit" name="updateRemoveKeyword" value="Submit"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updateRemoveKeyword") != null){
   			Connector con = new Connector();
   			if(key.removeKeyWords((String)request.getParameter("THID"), con.stmt, (String)request.getParameter("WID"))){
   				out.println("The keyword was successfully removed!");
   			}
   			else{
   				out.println("There was an issue with your selection.  The keyword was not removed.");
   				
   			}
   			
   			
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	else if(request.getParameter("addKeywords") != null){
   			%>
  		    <form action = "Keywords.jsp" method=post>
  			House ID:<input type = "text" name = "THID" value = "0"/><br>
  			Keyword to add:<input type = "text" name = "word" value = "0"/><br>
  			Language of Keyword:<input type = "text" name = "language" value = "0"/><br>
  			<input type = "submit" name="updateAddKeyword" value="Submit"/><br>
  			</form>
  		    <%
    	}
    	
    	else if(request.getParameter("updateAddKeyword") != null){
   			Connector con = new Connector();
			
    		if(key.addKeyWords((String)request.getParameter("THID"), con.stmt, (String)request.getParameter("word"), (String)request.getParameter("language"))){
   				out.println("The keyword was successfully added!");
   			}
   			else{
   				out.println("There was an issue with your selection.  The keyword was not added.");
   				
   			}
    	con.closeStatement();
    	con.closeConnection();
    	}
    	
    	
    	%>
   	<form action = "Keywords.jsp" method = post>
	<input type = submit name = "seeKeywords" value = "See the keywords of a house"/><br>
	<input type = submit name = "removeKeywords" value = "Remove a keyword to a house you own"/><br>
	<input type = submit name = "addKeywords" value = "Add a keyword to a house you own"/><br>
	</form>
	<br>
	<a href=MainMenu.jsp>Back to main</a> 
    	<%
    	
      }
    %>
</body>
</html>