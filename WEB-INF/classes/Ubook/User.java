package Ubook;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;



public class User {
	//BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
	public String setUpUser(Statement stmt, String userName, String password, String name, String address, String phoneNumber, String admin) {
		// TODO Auto-generated method stub
		

		String sql = null;
		//System.out.println("Please put in your preffered user name");
		//String userName = null;
//		while(userName == null){
//			try {
//				userName = MainMenu.input.readLine();
//			} catch (IOException e1) {
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			}
//			
//			
//			}
//
//		System.out.println("Please put in your password");
//		String password = null;
//		
//		try {
//			password = MainMenu.input.readLine();
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		
//		System.out.println("Please put in your full name");
//		String name = null;
//		
//		try {
//			name = MainMenu.input.readLine();
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		
//		System.out.println("Please put in your address");
//		String address = null;
//		
//		try {
//			address = MainMenu.input.readLine();
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		
//		System.out.println("Please put in your phone number");
//		String phoneNumber = null;
//		
//		try {
//			phoneNumber = MainMenu.input.readLine();
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		
//		String admin = "0";
//		System.out.println("Are you an Admin of the system? (Y/N)");
//		
//		try {
//			if(MainMenu.input.readLine().toLowerCase().equals("y")){
//				admin = "1";
//			}
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		
		
		sql = "SELECT login FROM Users WHERE login = '" + userName + "';";
		ResultSet rs = null;
		try {
			rs = stmt.executeQuery(sql);
				if(rs.isBeforeFirst()){
					System.out.println("That username has already been taken.  Please select a different one.\n");
					userName = null;
				}
			}
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();	
			}
		if(userName != null){
		sql = "INSERT INTO Users (login, name, password, address, phoneNumber, userType)"
				+ " VALUES( '" + userName + "', '" + name+"','" + password + "', '" + address+"','" + phoneNumber + "', '"+admin+"')";
		try{
   		 	stmt.executeUpdate(sql);		     
		 	}
		 	catch(Exception e)
		 	{
		 		System.out.println("cannot execute the query");
		 		System.out.println(e.getMessage());
		 		userName = null;
		 	}
		}
		//if(gottenResults == 0){
			//userName = null;
		//}
		
	    return userName;
	}

	public String loginUser(Statement stmt, String userName, String password) {
		//BufferedReader MainMenu.input = new BufferedReader(new InputStreamReader(System.in));
//		
//		System.out.println("Please put in your user name");
//		String userName = null;
//		
//		try {
//			userName = MainMenu.input.readLine();
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		
//		System.out.println("Please put in your password");
//		
//		String password = null;
//		try {
//			password = MainMenu.input.readLine();
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
		
		String sql = "SELECT password FROM Users WHERE login = '" + userName + "';";
		ResultSet rs = null;
		try {
			rs = stmt.executeQuery(sql);
			if(rs.isBeforeFirst()){
				while(rs.next()){
					
					if(!rs.getString("password").equals(password)){
						userName = null;
						//System.out.println("That is the wrong password "
							//	+ "for the username you entered");
						
					}
				}
			}
			else{
				userName = null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userName;
	}

	public int setAdmin(String userName, Statement stmt) {
		// TODO Auto-generated method stub
		
		String sql = "UPDATE Users Set userType = '1' WHERE login = '" + userName + "' AND userType = '0';";
		boolean done = false; 
		int rs = 0;
		try {
			rs = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rs;
	}

	public boolean setFavoriteTH(String userName, Statement stmt, String TH) {
		// TODO Auto-generated method stub
		boolean done = false;
		String sql = null;

		int haveFavorite = 0;
		
		if(viewFavoriteTH(userName, stmt)[0] != null){
			haveFavorite = 1;
		}

		java.util.Date dt = new java.util.Date();
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String currentTime = sdf.format(dt);

		
		if(TH.equals("DELETE")){
			sql = "DELETE FROM Favorites WHERE login = '" + userName + "';";
			//output = "You will have no favorite after this.";
		}
		else{
			if(haveFavorite != 0){
				sql = "UPDATE Favorites SET hid = '" +TH+ "', fvdate = '"+currentTime+"' WHERE login = '" + userName + "';";
			}
			else{
				sql = "INSERT INTO Favorites(hid, fvdate, login) VALUES('" +TH + "','"+currentTime+"', '"+userName+"');";
			}
			
		}
		

			try {
				stmt.executeUpdate(sql);
				done = true;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return done;
	}

	public String[] viewFavoriteTH(String userName, Statement stmt){
		ResultSet rs = null;
		String [] haveFavorite = new String[2];
		String sql = "Select F.hid, T.name FROM Favorites F, TH T WHERE F.login = '"+userName+"' AND F.hid = T.hid";
		
		try {
			rs = stmt.executeQuery(sql);
//			if(!rs.isBeforeFirst()){
//				System.out.println("You do not have a favorite house currently selected.");
//			}
			//else{
					while(rs.next()){
						//System.out.println("Your current favorite place to stay is:");
						//System.out.println("House ID: "+ rs.getString("F.hid") + ", House name: " + rs.getString("T.name"));
						//haveFavorite = rs.getInt("F.hid");
						haveFavorite[0] = rs.getString("F.hid");
						haveFavorite[1] = rs.getString("T.name");
					}
				
			//}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return haveFavorite;
	}
	
	public String[] alterProfile(String userName, Statement stmt, String password, String admin, String address, String fullName, String phoneNumber){
		String sql = "SELECT * from Users WHERE login = '"+userName+"';";
		String fullNameInternal = null;
		String adminInternal = null;
		String addressInternal = null;
		String phoneNumberInternal = null;
		String passwordInternal = null;
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				//System.out.println("User Name: "+rs.getString(1)+", Full Name: "+rs.getString(2)+", Admin(1 for yes, 0 for no): "+rs.getString(3)+", Address: "+rs.getString(5)+", Phone Number: "+rs.getString(6));
				
				fullNameInternal = rs.getString(2);
				adminInternal = rs.getString(3);
				addressInternal = rs.getString(5);
				phoneNumberInternal = rs.getString(6);
				passwordInternal = rs.getString(4);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			
				if(fullName != null && !fullName.isEmpty()){
					fullNameInternal = fullName;
				}
				if(admin != null && !admin.isEmpty()){
					adminInternal = admin;
				}
				if(address != null && !address.isEmpty()){
					addressInternal = address;
				}
				if(phoneNumber != null && !phoneNumber.isEmpty()){
					phoneNumberInternal = phoneNumber;
				}
				if(password != null && !password.isEmpty()){
					passwordInternal = password;
				}
				
				sql = "UPDATE Users SET name = '"+fullNameInternal+"', userType = '"+adminInternal+"', password = '"+passwordInternal+"', address = '"+addressInternal+"', phoneNumber = '"+phoneNumberInternal+"' WHERE login = '"+userName+"';";
				
				stmt.executeUpdate(sql);
				
				System.out.println("Information updated.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String[] result = new String[6];
		
		result[0] = userName;
		result[1] = fullNameInternal;
		result[2] = adminInternal;
		result[3] = addressInternal;
		result[4] = phoneNumberInternal;
		result[5] = passwordInternal;
		return result;
		
	}
	
	public String[] setViewProfile(String userName, Statement stmt) {
		//System.out.println("Here is your profile.");
		
		String sql = "SELECT * from Users WHERE login = '"+userName+"';";
		String fullName = null;
		String admin = null;
		String address = null;
		String phoneNumber = null;
		String password = null;
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				//System.out.println("User Name: "+rs.getString(1)+", Full Name: "+rs.getString(2)+", Admin(1 for yes, 0 for no): "+rs.getString(3)+", Address: "+rs.getString(5)+", Phone Number: "+rs.getString(6));
				
				fullName = rs.getString(2);
				admin = rs.getString(3);
				address = rs.getString(5);
				phoneNumber = rs.getString(6);
				password = rs.getString(4);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		System.out.println("Do you wish to update your profile? (Y/N)");
//		
//		try {
//			if(MainMenu.input.readLine().toLowerCase().equals("y")){
//				System.out.println("What do you wish to update your Full name to?  Leave blank to leave the same.");
//				String choice = MainMenu.input.readLine();
//				if(!choice.isEmpty()){
//					fullName = choice;
//				}
//				
//				System.out.println("What do you wish to update your password to?  Leave blank to leave the same.");
//				choice = MainMenu.input.readLine();
//				if(!choice.isEmpty()){
//					password = choice;
//				}
//				
//				System.out.println("What do you wish to update your address to?  Leave blank to leave the same.");
//				choice = MainMenu.input.readLine();
//				if(!choice.isEmpty()){
//					address = choice;
//				}
//				
//				System.out.println("What do you wish to update your phone number to?  Leave blank to leave the same.");
//				choice = MainMenu.input.readLine();
//				if(!choice.isEmpty()){
//					phoneNumber = choice;
//				}
//				
//				System.out.println("What do you wish to update your Administator status to? Input 1 for admin, input 0 for non admin. Leave blank to leave the same.");
//				choice = MainMenu.input.readLine();
//				if(!choice.isEmpty()){
//					admin = choice;
//				}
//				
//				sql = "UPDATE Users SET name = '"+fullName+"', userType = '"+admin+"', password = '"+password+"', address = '"+address+"', phoneNumber = '"+phoneNumber+"' WHERE login = '"+userName+"';";
//				
//				stmt.executeUpdate(sql);
//				
//				System.out.println("Information updated.");
//			}
//		} catch (IOException | SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//System.out.println("Exiting view profile menu.");
		String[] result = new String[6];
		
		result[0] = userName;
		result[1] = fullName;
		result[2] = admin;
		result[3] = address;
		result[4] = phoneNumber;
		result[5] = password;
		return result;
	}
	
	public List<UserInfo> topTrustedUsers(String amount, Statement stmt){
		String sql = "Select DISTINCT T.login2, sum(case when T.isTrusted = 1 then 1 else -1 end) AS trustedLevel FROM Trust T GROUP BY T.login2 ORDER BY trustedLevel DESC LIMIT "+amount+"; ";
		List<UserInfo> result = new ArrayList<UserInfo>();
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				//System.out.println("User Login: " + rs.getString("T.login2") + ", Trusted Level: "+rs.getString("trustedLevel") );
				result.add(new UserInfo(rs.getString("T.login2"),rs.getString("trustedLevel")));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//System.out.println("Exiting top trusted users Menu.");
		
		return result;
	}
	
	public List<UserInfo> topUsefulUsers(String amount, Statement stmt){
		String sql = "SELECT distinct F.login, AVG(R.rating) AS AVGuse FROM Feedback F, Rates R WHERE F.fid = R.fid GROUP BY F.login ORDER BY AVGuse DESC LIMIT 10;";
		List<UserInfo> result = new ArrayList<UserInfo>();
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				//System.out.println("User Login: " + rs.getString("F.login") + ", Usefulness of Feedback Average: "+rs.getString("AVGuse") );
				result.add(new UserInfo(rs.getString("F.login"),rs.getString("AVGuse")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//System.out.println("Exiting top trusted users Menu.");
		return result;
	}
	
	public int degreeOfSeperation(String userName, String checkName,Statement stmt){
		int result = -1;
		
		String sql = "SELECT F.login FROM Favorites F WHERE F.login = '"+checkName+"' AND F.hid = ANY(SELECT F2.hid FROM Favorites F2 WHERE F2.login = '"+userName+"');";
		boolean found = false;
		ResultSet rs = null;
		
		
		try {
			rs = stmt.executeQuery(sql);
			if(rs.isBeforeFirst()){
				result = 1;
				found = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(!found){
			sql = "SELECT F.login FROM Favorites F WHERE F.login = '"+checkName+"' AND F.hid = ANY(SELECT F4.hid FROM Favorites F4 WHERE F4.login = ANY(SELECT F2.login from Favorites F2 WHERE F2.hid = ANY(SELECT F3.hid FROM Favorites F3 WHERE F3.login = '"+userName+"')))";
			
			try {
				rs = stmt.executeQuery(sql);
				if(rs.isBeforeFirst()){
					result = 2;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	public boolean checkAdmin(String userName, Statement stmt){
		boolean admin = false;
		
		String sql = "SELECT login FROM Users WHERE login = '"+userName+"' AND userType = '1';";
		
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			if(rs.isBeforeFirst()){
				admin = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return admin;
	}

}
