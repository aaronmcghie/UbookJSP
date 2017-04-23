<%@ page language="java" import= "Ubook.*"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<body>
<% 


User user = new User();

if(request.getParameter("login") != null){
String userName = request.getParameter("userName");
String password = request.getParameter("password");

Connector con = new Connector();


session.setAttribute("user", user.loginUser(con.stmt, userName, password));




if(session.getAttribute("user") != null)
{
	out.println("Welcome back "+ (String)(session.getAttribute("user"))+ "<br>"+" <a href=MainMenu.jsp>Back to main</a>");
	if(user.checkAdmin(userName, con.stmt))
	{
		session.setAttribute("admin", true);
	}
	else
	{
		session.setAttribute("admin", false);	
	}
	con.closeStatement();
	con.closeConnection();
}
else{
	out.println("There was an issue with your login. Please try again. "+"<br>"+" <a href=MainMenu.jsp>Back to main</a>");
	con.closeStatement();
	con.closeConnection();
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
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
<% 
}
else if(request.getParameter("doneRegister") != null){

	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	String fullName = request.getParameter("fullName");
	String address = request.getParameter("address");
	String phoneNumber = request.getParameter("phoneNumber");
	String admin = "0";
	if(request.getParameterValues("admin") != null){
		admin = "1";
	}
	Connector con = new Connector();
	if(!userName.isEmpty() && !password.isEmpty()){
		session.setAttribute("user", user.setUpUser(con.stmt, userName, password, fullName, address, phoneNumber, admin));
	}

	con.closeStatement();
	con.closeConnection();

	if(session.getAttribute("user") != null){
		out.println("Welcome back "+ (String)(session.getAttribute("user"))+"<br>" +" <a href=MainMenu.jsp>Back to main</a>");
	}
	else{
		out.println("There was an issue with your registration.  Do you want to try again?");
				
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
	Connector con = new Connector();
	String[] result = user.setViewProfile((String)session.getAttribute("user"), con.stmt);
	con.closeStatement();
	con.closeConnection();
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
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	<%
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
	
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
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
	
	Connector con = new Connector();
	String[] result = user.alterProfile((String)session.getAttribute("user"), con.stmt, request.getParameter("password"), admin, request.getParameter("address"),request.getParameter("fullName"), request.getParameter("phoneNumber"));
	con.closeStatement();
	con.closeConnection();
	
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
	%>
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	<%
}

else if (request.getParameter("viewFavorite") != null){
	Connector con = new Connector();
	String [] result = user.viewFavoriteTH((String)session.getAttribute("user"), con.stmt);
	con.closeStatement();
	con.closeConnection();
	
	out.println("Favorite Temporary House"+"<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("House ID: " +result[0] + "<br>");
	out.println("======================================================================================================" + "<br>");
	out.println("House Name: " + result[1] + "<br>");
	out.println("======================================================================================================" + "<br>");
	%>
	<form action = "User.jsp" method=post>
	<input type = submit name = "changeFavorite" value = "Change Favorite"/>
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
	<%
}


else if(request.getParameter("changeFavorite") != null){
	%>
	<form action = "User.jsp" method=post>
	Favorite THID: <input type = "text" name = "FavoriteTHID" value = "0"/><br>
	<input type = submit name = "updateFavorite" value = "Update Favorite"/><br>
	<a href=User.jsp>Back to User</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
	<%
}

else if(request.getParameter("updateFavorite") != null){
	
	Connector con = new Connector();
	
	if(user.setFavoriteTH((String)session.getAttribute("user"), con.stmt, request.getParameter("FavoriteTHID"))){
		out.println("Your favorite house was updated!" + "<br>");
	}
	else{
		out.println("Your favorite house was not updated due to an issue with the server." + "<br>");
	}
	con.closeStatement();
	con.closeConnection();

	%>
	<form>
	<a href=User.jsp>Back to User</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
	<%
}

else if(request.getParameter("viewSeperation") != null){
	%>
	<form action = "User.jsp" method=post>
	First User: <input type = "text" name = "FirstName" value = "First User Name"/><br></br>
	Second User:<input type = "text" name = "SecondName" value = "Second User Name"/><br><br/>
	<input type = submit name = "updateSeperation" value = "See Seperation"/>
	<br>
	<a href=User.jsp>Back to User</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
	<%
}

else if(request.getParameter("updateSeperation") != null){
	
	Connector con = new Connector();
	
	int result = user.degreeOfSeperation(request.getParameter("FirstName"), request.getParameter("SecondName"), con.stmt);
	
	con.closeStatement();
	con.closeConnection();
	
	if(result != -1){

		out.println("======================================================================================================" + "<br>");
		out.println(request.getParameter("FirstName") + " and " + request.getParameter("SecondName") + " degree of seperation is "+Integer.toString(result) + "." + "<br>");
		out.println("======================================================================================================" + "<br>");
	}
	else{
		out.println("======================================================================================================" + "<br>");
		out.println(request.getParameter("FirstName") + " and " + request.getParameter("SecondName") + " are not connected by their favorite houses."+"<br>");
		out.println("======================================================================================================" + "<br>");
		
	}
	%>
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	<%
}
else if(request.getParameter("viewTrusted") != null){
	%>
	<form action = "User.jsp" method=post>
	Number of top trusted users:<input type = "text" name = "amountTrusted" value = "Amount of top trusted users"/><br/><br/>
	<input type = "submit" name="updateTrusted" value="view top trusted users"/>
	
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
	<% 
}

else if(request.getParameter("viewUseful") != null){
	%>
	<form action = "User.jsp" method=post>
	Number of top useful users:<input type = "text" name = "amountUseful" value = "Amount of top useful users"/><br/><br/>
	<input type = "submit" name="updateUseful" value="view top useful users"/>
	
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	</form>
	<% 
}

else if(request.getParameter("updateTrusted") != null){
	Connector con = new Connector();
	List<UserInfo> results = user.topTrustedUsers((String)request.getParameter("amountTrusted"), con.stmt);
	
	con.closeStatement();
	con.closeConnection();
	%>
	<ol>
	<% 
		for(int i = 0; i < results.size(); i++)
		{
			UserInfo current = results.get(i);
			out.println("======================================================================================================" + "<br>");
			out.println("Username: " + current.getName() + " Trusted Level: " + current.getValue() + "<br>");
			out.println("======================================================================================================" + "<br>");
		}
	%>
	</ol>

	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	<% 
}

else if(request.getParameter("updateUseful") != null){
	Connector con = new Connector();
	List<UserInfo> results = user.topUsefulUsers((String)request.getParameter("amountTrusted"), con.stmt);
	
	con.closeStatement();
	con.closeConnection();
	%>
	<ol>
	<% 
		for(int i = 0; i < results.size(); i++)
		{
			UserInfo current = results.get(i);
			out.println("======================================================================================================" + "<br>");
			out.println("Username: " + current.getName() + " Average Useful Rating: " + current.getValue() + "<br>");
			out.println("======================================================================================================" + "<br>");
		}
	%>
	</ol>

	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	<% 
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
	<input type = submit name = "viewSeperation" value = "View degree of seperation."/>
	</form>
	
	<%if(session.getAttribute("admin") != null && (boolean)session.getAttribute("admin")){
		%>
		<form action = "User.jsp" method = post>
		<input type = submit name = "viewTrusted" value = "View top trusted users."/>
		</form>
		
		<form action = "User.jsp" method = post>
		<input type = submit name = "viewUseful" value = "View top useful users."/>
		</form>
		<%
	}
	%>
	<a href=User.jsp>Back to User actions</a>
	<br>
	<a href=MainMenu.jsp>Back to main</a>
	<%
	
}
 %>
<%

%>
</body>
</html>