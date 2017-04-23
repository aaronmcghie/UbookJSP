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
    	  
   	  UserFeedback userFeed = new UserFeedback();
   	  THFeedback THFeed = new THFeedback();
    %>
        <h1>Create and View Feedback</h1>
        <p>Welcome to Feedback.</p>
        
    <%
    if(request.getParameter("createTHFeedback") != null){
    	%>
    	<form action = "Feedback.jsp" method=post>
		THID:<input type = "text" name = "THID"/><br>
		Text input:<input type = "text" name = "TextTH"/><br>
		Score:<input type = "text" name = "THScore"/><br>
		<input type = "submit" name="updateCreateTHFeed" value="Submit your TH feedback."/>
		</form>
    	<%
    }
    
    else if(request.getParameter("updateCreateTHFeed") != null){
    	Connector con = new Connector();
    	if(THFeed.thReview((String)session.getAttribute("user"), con.stmt, request.getParameter("THID"), request.getParameter("TextTH"), request.getParameter("THScore"))){
			%>
			<h2>You have successfully submitted your housing Review!</h2>
			<%    		
    	}
    	else{
    		%>
			<h2>There was an issue with your review.  Please try again.</h2>
			<%
    	}
    	con.closeStatement();
    	con.closeConnection();
    		
    }
    
	else if(request.getParameter("viewUsefulTHFeedback") != null){
	    %>
	    <form action = "Feedback.jsp" method=post>
		Number of top useful TH feedbacks:<input type = "text" name = "amountUsefulTH" value = "Amount"/><br>
		THID to see feedback for:<input type = "text" name = "THID"/><br>
		<input type = "submit" name="updateUsefulTH" value="view top useful Feedbacks for a TH"/><br>
		</form>
	    <%
	}
   else if(request.getParameter("updateUsefulTH") != null){
    	Connector con = new Connector();
    	List<reviewedFeedback> results = THFeed.viewMostUsefulFeedback(request.getParameter("amountUsefulTH"), con.stmt, request.getParameter("THID"));  		
			for(int i = 0; i < results.size(); i++)
			{
				reviewedFeedback current = results.get(i);
				out.println("======================================================================================================" + "<br>");
				out.println("Review #"+ Integer.toString(i+1) + "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("FeedbackID: " + current.getFID()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("TH score: " + current.getScore()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Feedback Text: " + current.getText()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("User name of reviewer: " + current.getLogin()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Feedback date: " + current.getDate()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("Feedback average usefullness score: " + current.getUseScore()+ "<br>");
				out.println("======================================================================================================" + "<br>");
				out.println("<br>");
			}
    	con.closeStatement();
    	con.closeConnection();
    		
	}
    
	else if(request.getParameter("reviewTHFeedback") != null){
	    %>
	    <form action = "Feedback.jsp" method=post>
		Feedback ID to rate:<input type = "text" name = "FID" value = "FID"/><br>
		Score(0 for useless, 1 for somewhat useful, 2 for highly useful):<input type = "text" name = "FIDScore" value= "Score"/><br>
		<input type = "submit" name="updateReviewTHFeed" value="Submit your Review"/><br>
		</form>
	    <%
	}
    
	else if(request.getParameter("updateReviewTHFeed") != null){
    	Connector con = new Connector();
    	if(THFeed.reviewFeedback((String)session.getAttribute("user"), con.stmt, request.getParameter("FID"), request.getParameter("FIDScore"))){
			%>
			<h2>You have successfully submitted your Feedback Review!</h2>
			<%    		
    	}
    	else{
    		%>
			<h2>There was an issue with your review.  Please try again.</h2>
			<%
    	}
    	con.closeStatement();
    	con.closeConnection();
	}
    
	else if(request.getParameter("viewUserFeedback") != null){
	   %>
	    <form action = "Feedback.jsp" method=post>
		User to see trusted level:<input type = "text" name = "userName" value = "User Name"/><br>
		<input type = "submit" name="updateSeeUserTrust" value="See trusted level"/><br>
		</form>
	    <%
    }
    
   else if(request.getParameter("updateSeeUserTrust") != null){
    	Connector con = new Connector();
    	int result = userFeed.viewUserFeedback(request.getParameter("userName"), con.stmt);  		
		
    	out.println("======================================================================================================" + "<br>");
		out.println("User name:"+ request.getParameter("userName") + " Trusted level: "+ Integer.toString(result)+ " <br>");
		out.println("======================================================================================================" + "<br>");
    	
    	con.closeStatement();
    	con.closeConnection();
    		
	}
	    
    
    
	else if(request.getParameter("reviewUser") != null){
	   %>
	    <form action = "Feedback.jsp" method=post>
		User to rate:<input type = "text" name = "userName" value = "User Name"/><br>
		Trusted:<input type = "checkbox" name = "trusted"/><br>
		<input type = "submit" name="updateReviewUser" value="Submit user review"/><br>
		</form>
	    <%
    }
    
	else if(request.getParameter("updateReviewUser") != null){
    	Connector con = new Connector();
    	int trusted = 0;
    	if(request.getParameter("trusted") != null){
    		trusted = 1;
    	}
    	
    	
    	if(userFeed.reviewUsers((String)session.getAttribute("user"), con.stmt, trusted, request.getParameter("userName"))){
			%>
			<h2>You have successfully submitted your user Review!</h2>
			<%    		
    	}
    	else{
    		%>
			<h2>There was an issue with your review.  Please try again.</h2>
			<%
    	}
    	con.closeStatement();
    	con.closeConnection();
	}
    
    %>
    <form action = "Feedback.jsp" method = post>
    <br>
	<input type = submit name = createTHFeedback value = "Review a TH you stayed at."/><br>
	<input type = submit name = viewUsefulTHFeedback value = "View the most useful feedbacks for a TH"/><br>
	<input type = submit name = reviewTHFeedback value = "Review a TH feedback left by another user"/><br>
	</form>
	
	<form action = "Feedback.jsp" method = post>
	<input type = submit name = "viewUserFeedback" value = "See a user's trusted level."/><br>
	<input type = submit name = "reviewUser" value = "Say whether you trust a user."/><br>
	</form>
	<br>
	<a href=MainMenu.jsp>Back to main</a> 
    <%
      }
    %>
  </body>
</html>