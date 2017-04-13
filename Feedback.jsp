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
    	  
   	  UserFeedback userFeed = new UserFeedback();
   	  THFeedback THFeed = new THFeedback();
    %>
        <h1>Create and View Feedback</h1>
        <p>Welcome to Feedback.</p>
        
    <%
    else if(request.getParameter("createTHFeedback") != null){
    	%>
    	<form action = "Feedback.jsp" method=post>
	THID:<input type = "text" name = "THID"/><br>
	Text input:<input type = "text" name = "TextTH"/><br>
	Score:<input type = "text" name = "THScore"/><br>
	<input type = "submit" name="updateCreateTHFeed" value="Submit your TH feedback."/>
	<br>
	<a href=Feedback.jsp>Back to Feedback actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
    	<%
    }
    
	else if(request.getParameter("viewUsefulTHFeedback") != null){
	    %>
	    <form action = "Feedback.jsp" method=post>
		Number of top useful TH feedbacks:<input type = "text" name = "amountUsefulTH" value = "Amount"/><br>
		THID to see feedback for:<input type = "text" name = "THID"/><br>
		<input type = "submit" name="updateUsefulTH" value="view top useful Feedbacks for a TH"/><br>
		<br>
		<a href=Feedback.jsp>Back to Feedback actions</a>
		<br>
		<a href=MainMenu.jsp>Back to main</a>
		</form>
	    <%
	}
	    
	else if(request.getParameter("reviewTHFeedback") != null){
	    %>
	    <form action = "Feedback.jsp" method=post>
		Feedback ID to rate:<input type = "text" name = "FID" value = "FID"/><br>
		Score(0 for useless, 1 for somewhat useful, 2 for highly useful):<input type = "text" name = "FIDScore" value= "Score"/><br>
		<input type = "submit" name="updateReviewTHFeed" value="view top useful Feedbacks for a TH"/><br>
		<br>
		<a href=Feedback.jsp>Back to Feedback actions</a>
		<br>
		<a href=MainMenu.jsp>Back to main</a>
		</form>
	    <%
	}
    
	else if(request.getParameter("viewUserFeedback") != null){
	   %>
	    <form action = "Feedback.jsp" method=post>
		User to see trusted level:<input type = "text" name = "userName" value = "User Name"/><br>
		<input type = "submit" name="updateSeeUserTrust" value="See trusted level"/><br>
		<br>
		<a href=Feedback.jsp>Back to Feedback actions</a>
		<br>
		<a href=MainMenu.jsp>Back to main</a>
		</form>
	    <%
    }
    
	else if(request.getParameter("reviewUser") != null){
	   %>
	    <form action = "Feedback.jsp" method=post>
		User to rate:<input type = "text" name = "userName" value = "User Name"/><br>
		Trusted:<input type = "checkbox" name = "trusted"/><br>
		<input type = "submit" name="updateReviewUser" value="submit user review"/><br>
		<br>
		<a href=Feedback.jsp>Back to Feedback actions</a>
		<br>
		<a href=MainMenu.jsp>Back to main</a>
		</form>
	    <%
    }
    %>
    "createTH"<form action = "Feedback.jsp" method = post>
	<input type = submit name = createTHFeedback value = "Review a TH you stayed at."/>
	<input type = submit name = viewUsefulTHFeedback value = "View the most useful feedbacks for a TH"/>
	<input type = submit name = reviewTHFeedback value = "Review a TH feedback left by another user"/>
	</form>
	
	<form action = "Feedback.jsp" method = post>
	<input type = submit name = "viewUserFeedback" value = "See a user's trusted level."/>
	<input type = submit name = "reviewUser" value = "Say whether you trust a user."/>
	</form>
    
    <a href=Feedback.jsp>Back to Feedback menu</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a> 
    <%
      }
    %>
  </body>
</html>