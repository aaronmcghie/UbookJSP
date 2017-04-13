package Ubook;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserFeedback {

	public boolean reviewUsers(String userName, Statement stmt, int trusted, String ratedUser) {

		boolean done = false;
			
		String sql = null;
	
		sql = "INSERT INTO Trust VALUES('"+userName+"','"+ratedUser+"','"+Integer.toString(trusted)+"');";
		
		try{
			stmt.executeUpdate(sql);
			done = true;
		}
		catch(SQLException e1){
			e1.printStackTrace();
		}
		
		return done;	
		
	}
	
	
	public int viewUserFeedback(String reviewName, Statement stmt){
		int result = 0;
		ResultSet rs = null;
		String sql = "Select isTrusted from Trust where login2 = '"+reviewName+"'";
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				if(rs.getInt(1) == 1){
					result++;
				}
				else{
					result--;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
}
