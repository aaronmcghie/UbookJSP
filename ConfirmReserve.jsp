<%@ page language="java" import= "Ubook.*"%>
<%@ page import = "java.util.*" %>
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
        <h1>Reservation Added To Cart!</h1>
        <%
   
          if(session.getAttribute("reserveList") == null) {
            out.print("<p>Error <a href =\"BRTH.jsp\">Try again</a></p> ");
          }
          else {
            Connector con = new Connector();
            TH suggest = new TH();
            List<HouseInfo> result = suggest.THSuggestions((String)session.getAttribute("hid"), (String)session.getAttribute("user"), con.stmt);
            con.closeStatement();
            con.closeConnection();
            List<Reserve> reserveList = (List<Reserve>)session.getAttribute("reserveList");
            reserveList.add(new Reserve((String)session.getAttribute("hid"), (String)request.getParameter("fromDate"), (String)request.getParameter("toDate")));
            out.print("<p>Reservation added to your Reservation Cart!</p>");
            
            out.println("Here are some THs you might like as well!" + "<br>");
            
            for(int i = 0; i < result.size(); i++){
            	HouseInfo current = result.get(i);
    			out.println("======================================================================================================" + "<br>");
    			out.println("HouseID: " + current.getID()+ "<br>");
    			out.println("======================================================================================================" + "<br>");
    			out.println("Number of Unique Guest Visits: " + current.getCount()+ "<br>");
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
            
            out.print("<p><a href = \"ReserveTH.jsp\">Make another Reservation</a> or <a href = \"ReserveCheckout.jsp\">Checkout!</a></p>");
          }
        %>
        <a href=MainMenu.jsp>Back to main</a>
    <%
      }
    %>
  </body>
</html>