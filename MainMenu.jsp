<%@ page language="java" import= "Ubook.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script LANGUAGE="javascript">

function check_all_fields(form_obj){
	alert(form_obj.UserName.value+"='"+form_obj.Password.value+"'");
	if( form_obj.UserName.value == "" && form_obj.Password.value == ""){
		alert("Login info should be nonempty");
		return false;
	}
	return true;
}


function checkName(String obj){
	if(obj == null ||obj == ""){
		return false;
	}
	return true;
}
</script> 
</head>
<body>
<%
String user = (String)session.getAttribute("user");
if(user == null){
%>

	Form1: login user name:
	<form action = "User.jsp" method=post onsubmit="return check_all_fields(this)">
	UserName:<input type = "text" name = "userName"/><br/><br/>
	Password:<input type = "password" name = "password"/><br/><br/>
	<input type = "submit" name="login" value="login"/>
	<br>
	<input type = submit name = registerUser value= "Register a new user" />
	</form>
	

<%


} else {
	out.println("Welcome " +user);
	
	
	%>

	<br><br/>

  <ul>
  		<li>
  			<a href = User.jsp>User Actions</a>
  		</li>
		<li>
			<a href = "TH.jsp">Register and edit your THs</a>
		</li>
		<li>
			<a href = "BRTH.jsp">Browse and Reserve THs</a>
		</li>
		<li>
			<a href = "RecordStay.jsp">Record a Stay</a>
		</li>
		<li>
			<a href = "Feedback.jsp">Create and view feedback</a>
		</li>
		<li>
			<a href = "Stats.jsp">Create and view Statistics</a>
		</li>
		<li>
			<a href = "ViewStays.jsp">View your Stays and Reservations</a>
		</li>
	</ul>
	
		<br></br>
	<form action = "MainMenu.jsp" method=post >
	<input type = submit name = logout value = "logout"/></form>
	

	<%
	if(request.getParameter("logout") != null){
		session.invalidate();
		response.sendRedirect("index.html");
	}

	
}
%>  
</body>
</html>