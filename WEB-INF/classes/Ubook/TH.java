package Ubook;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TH {
	//

	public String verifyHouseID(String userName, String houseID,Statement stmt){
 
		ResultSet rs = null;
		
	/*	
		if(houseID != null && !houseID.isEmpty()){
			try {
				houseID = MainMenu.input.readLine();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			}

		}
		*/
		String sql = "SELECT * FROM TH WHERE login = '" + userName + "' AND hid = '" +houseID+ "';";
		try {
			rs = stmt.executeQuery(sql);
			if(!rs.isBeforeFirst()){
				//System.out.println("You do not have a house registered with that HouseID. Please try again. \n");
				houseID = null;
				}
			}

			catch(SQLException e){
				e.printStackTrace();
			}
		
	return houseID;
	}
	
	public String registerHouse(String userName, Statement stmt, String houseName, String address, String city, String state, String phoneNumber, String yearBuilt, String category, String URL) {
		String sql = "INSERT INTO TH (category, name, address, URL, phoneNumber, yearBuilt, login, city, state)"
				+ " VALUES( '" + category + "', '" + houseName+"','" + address + "', '" + URL+"','" + phoneNumber + "',"
						+ "'" + yearBuilt + "','" + userName + "','" + city + "','" + state + "')";
		try{
   		    stmt.executeUpdate(sql);
   		    return "Success!";
	 	}
	 	catch(SQLException e){
	 		return e.getMessage();
	 	}
	}

	public String listOwnedHouses(String userName, Statement stmt) {
		// TODO Auto-generated method stub
		String sql = "SELECT hid, name FROM TH WHERE login = '" + userName + "';";
		ResultSet rs = null;
		StringBuilder output = new StringBuilder();
		try {
			rs = stmt.executeQuery(sql);
			if(!rs.isBeforeFirst()){
				output.append("<p>You do not have any houses registered in the system.</p>");
				return output.toString();
			}
			output.append("<ul>");
			while(rs.next()){
				output.append("<li>House Name: " + rs.getString("name") + "<a href = \"EditTH.jsp?id=" + rs.getString("hid") +"\"> Edit!</a></li>");
			}
			output.append("</ul>");
			return output.toString();
		}
		catch(SQLException e){
			return e.getMessage();
		}
	}

	public String changeHouse(String userName, Statement stmt, String hid, String houseName, String address, String city, String state, String phoneNumber, String yearBuilt, String category, String URL) {
		String houseID = verifyHouseID(userName, hid, stmt);
		String sql;
		if(houseID == null){
			return "<p>You don't own that house!</p>";
		}		
		sql = "UPDATE TH SET category = '" + category+ "',name = '" + houseName+ "',address = '" + address+ "',URL = '" + URL+ "',phoneNumber = '" + phoneNumber+ "',"
				+ "yearBuilt = '" + yearBuilt+ "', city = '"+city+"', state = '"+state+"' WHERE hid = '" + hid + "' AND login = '" + userName + "';";
		try {
			stmt.executeUpdate(sql);
			return "<p>Your TH was edited!</p>";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return e.getMessage();
		}
	}
	

	
	public List<HouseInfo> THSuggestions(String THID, String userName, Statement stmt){
		List<HouseInfo> results = new ArrayList<HouseInfo>();
		String sql = "SELECT DISTINCT V.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login, COUNT(distinct V.login) AS guestCount FROM Visits V, TH T WHERE V.login = ANY(SELECT DISTINCT V2.login FROM Visits V2 WHERE V2.hid = '"+THID+"' AND V2.login != '"+userName+"') AND V.hid != '"+THID+"' AND V.hid = T.hid GROUP BY  V.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login ORDER BY guestCount DESC; ";
		//String sql = "SELECT DISTINCT V.hid, COUNT(distinct V.login) AS guestCount FROM  Visits V WHERE V.login = ANY(SELECT DISTINCT V2.login FROM 5530db34.Visits V2 WHERE V2.hid = '"+THID+"' AND V2.login != '"+userName+"') AND V.hid != '"+THID+"' GROUP BY  V.hid ORDER BY guestCount DESC; ";
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				results.add (new HouseInfo(rs.getString("V.hid"),rs.getString("T.name"),rs.getString("T.category"),rs.getString("T.address"),rs.getString("T.city"),rs.getString("T.state"),rs.getString("T.yearBuilt"),rs.getString("T.phoneNumber"),rs.getString("T.URL"),rs.getString("T.login"), rs.getString("guestCount")));
			
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return results;
	}

	public HouseInfo THInfo(String THID, Statement stmt){
		String sql = "SELECT T.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login FROM "
				+ "TH T WHERE T.hid = '"+THID+"' ;" ;
		ResultSet rs = null;
		HouseInfo result = null;
		try {
			rs = stmt.executeQuery(sql);
			
			
			while(rs.next()){
				result = new HouseInfo(rs.getString("T.hid"),rs.getString("T.name"),rs.getString("T.category"),rs.getString("T.address"),rs.getString("T.city"),rs.getString("T.state"),rs.getString("T.yearBuilt"),rs.getString("T.phoneNumber"),rs.getString("T.URL"),rs.getString("T.login"), "0'");
			}
		}
		 catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}

	
	

