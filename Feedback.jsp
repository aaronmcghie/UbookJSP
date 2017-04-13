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
    	
    }
    
	else if(request.getParameter("viewUsefulTHFeedback") != null){
	    	
	}
	    
	else if(request.getParameter("reviewTHFeedback") != null){
		
	}
    
	else if(request.getParameter("viewUserFeedback") != null){
    	
    }
    
	else if(request.getParameter("reviewUser") != null){
    	
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