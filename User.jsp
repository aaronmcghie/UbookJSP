<%@ page language="java" import= "Ubook.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<body>
<% 

Connector con = new Connector();
User user = new User();

if(request.getParameter("login") != null){
String userName = request.getParameter("userName");
String password = request.getParameter("password");




session.setAttribute("user", user.loginUser(con.stmt, userName, password));

con.closeStatement();
con.closeConnection();


if(session.getAttribute("user") != null)
{
	out.println("Welcome back "+ (String)(session.getAttribute("user"))+ "<br>"+" <a href=\"MainMenu.jsp\">Back to main</a>");
	if(user.checkAdmin(userName, con.stmt))
	{
		session.setAttribute("admin", true);
	}
	else
	{
		session.setAttribute("admin", false);	
	}
}
else{
	out.println("There was an issue with your login. Please try again. "+"<br>"+" <a href=\"MainMenu.jsp\">Back to main</a>");
}
}

else if(request.getParameter("registerUser") != null){
	%>
	Registration Information:
	<form action = "User.jsp" method=post onsubmit="return check_all_fields(this)">
	UserName:<input type = "text" name = "userName"/><br/><br/>
	Password:<input type = "text" name = "password"/><br/><br/>
	FullName:<input type = "text" name = "fullName"/><br/><br/>
	Address:<input type = "text" name = "address"/><br/><br/>
	phoneNumber:<input type = "text" name = "phoneNumber"/><br/><br/>
	admin:<input type = "checkbox" name = "admin"/><br/><br/>
	
	<input type = "submit" name="doneRegister" value="RegisterUser"/>
	</form>
<% 
}
else if(request.getParameter("doneRegister") != null){

	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	String fullName = request.getParameter("FullName");
	String address = request.getParameter("address");
	String phoneNumber = request.getParameter("phoneNumber");
	String admin = "0";
	if(request.getParameterValues("admin") != null){
		admin = "1";
	}
	
	session.setAttribute("user", user.setUpUser(con.stmt, userName, password, fullName, address, phoneNumber, admin));


	con.closeStatement();
	con.closeConnection();

	if(session.getAttribute("user") != null){
		out.println("Welcome back "+ (String)(session.getAttribute("user"))+"<br>" +" <a href=\"MainMenu.jsp\">Back to main</a>");
	}
	else{
		out.println("THere was an issue with your registration.  Do you want to try again?");
				
		%>
		
		<form action = "User.jsp" method=post>
		<input type = submit name = registerUser value= "Yes" />
		
		</form>
		<form action = "MainMenu.jsp" method=post>
		<input type = submit name = cancelRegister value= "No" />
		</form>
		<%
	}
}

else if(request.getParameter("viewProfile") != null){
	String[] result = user.setViewProfile((String)session.getAttribute("user"), con.stmt);
	out.println("User Profile");
	out.println("======================================================================================================" + "<br>");
	out.println("User Name: " + session.getAttribute("user") + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Full Name: " + result[1] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Admin(1 for yes, 0 for no): " + result[2] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Address: " +result[3] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Phone Number: " + result[4] + "<br>");
	out.println("======================================================================================================" + "<br>");
	
	%>
	
		
	<form action = "User.jsp" method = post>
	<input type = submit name = changeProfile value = "Alter user profile"/>
	</form>
	<br>
	<%
	
	out.println("<a href=\"MainMenu.jsp\">Back to main</a>" );
}

else if(request.getParameter("changeProfile") != null){
	%>
	
	Form1: Change User Information:
	<form action = "User.jsp" method=post>
	FullName:<input type = "text" name = "fullName" value = "Full Name"/><br/><br/>
	Password:<input type = "password" name = "password" value = "password"/><br/><br/>
	Admin:<input type = "checkBox" name = "admin" value = "Is Admin?"/><br/><br/>
	Address:<input type = "text" name = "address" value = "Address"/><br/><br/>
	PhoneNumber:<input type = "text" name = "phoneNumber" value = "Phone Number"/><br/><br/>
	<input type = "submit" name="updateProfile" value="updateProfile"/>
	</form>
	
	<%
}

else if(request.getParameter("updateProfile") != null){
	String admin = null;
	if(request.getParameter("admin") != null){
		admin = "1";
		session.setAttribute("admin", true);
	}
	else{
		admin = "0";
		session.setAttribute("admin", false);
	}
	String[] result = user.alterProfile((String)session.getAttribute("user"), con.stmt, request.getParameter("password"), admin, request.getParameter("address"),request.getParameter("fullName"), request.getParameter("phoneNumber"));
	
	out.println("Updated User Profile Info");
	out.println("======================================================================================================" + "<br>");
	out.println("User Name: " + session.getAttribute("user") + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Full Name: " + result[1] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Admin(1 for yes, 0 for no): " + result[2] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Address: " +result[3] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("Phone Number: " + result[4] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("<a href=\"MainMenu.jsp\">Back to main</a>" );
}

else if (request.getParameter("viewFavorite") != null){
	String [] result = user.viewFavoriteTH((String)session.getAttribute("user"), con.stmt);
	
	out.println("Favorite Temporary House"+"<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("House ID: " +result[0] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("House Name: " + result[1] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("<a href=\"MainMenu.jsp\">Back to main</a>" );
}

else if(request.getParameter("viewSeperation") != null){
	%>
	<form action = "User.jsp" method=post>
	First User: <input type = "text" name = "FirstName" value = "First User Name"/><br></br>
	Second User:<input type = "text" name = "SecondName" value = "Second User Name"/><br><br/>
	<input type = submit name = "updateSeperation" value = "See Seperation"/>
	<a href=\"User.jsp\">Back to User</a>
	<a href=\"MainMenu.jsp\">Back to main</a>
	</form>
	<%
}

else if(request.getParameter("updateSeperation") != null){
	int result = user.degreeOfSeperation(request.getParameter("FirstName"), request.getParameter("SecondName"), con.stmt);
	
	if(result != -1){

		out.println("======================================================================================================" + "<br>");
		out.println(request.getParameter("FirstName") + " and " + request.getParameter("SecondName") + "degree of seperation is "+Integer.toString(result) + "." + "<br>");
		out.println("======================================================================================================" + "<br>");
	}
	else{
		out.println("======================================================================================================" + "<br>");
		out.println(request.getParameter("FirstName") + " and " + request.getParameter("SecondName") + " are not connected by their favorite houses."+"<br>");
		out.println("======================================================================================================" + "<br>");
		
	}
	out.println("<a href=\"MainMenu.jsp\">Back to main</a>" );	
}
else{
	%>
		
	<form action = "User.jsp" method = post>
	<input type = submit name = viewProfile value = "View/alter user profile"/>
	</form>

	
	
	<form action = "User.jsp" method = post>
	<input type = submit name = viewFavorite value = "View/change favorite temporary housing"/>
	</form>
	
	<form action = "User.jsp" method = post>
	<input type = submit name = changeProfile value = "Change current favorite T"/>
	</form>
	
	<form action = "User.jsp" method = post>
	<input type = submit name = "viewSeperation" value = "View degree of seperation."/>
	</form>
	
	<%if(session.getAttribute("admin") != null && (boolean)session.getAttribute("admin")){
		%>
		<form action = "User.jsp" method = post>
		<input type = submit name = "viewTrusted" value = "View top trusted users."/>
		</form>
		
		<br></br>
		
		<form action = "User.jsp" method = post>
		<input type = submit name = "viewUseful" value = "View top useful users."/>
		</form>
		<%
	}
	
}
 %>
<%

%>
</body>
</html>