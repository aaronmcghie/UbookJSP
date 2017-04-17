package Ubook;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class dateInfo {
	
	public boolean createAvailability(String houseID, Statement stmt, String startDate, String endDate, String priceNight) {

		
		boolean changed = false;
		
		
		String sql = "INSERT INTO Period (fromDate, toDate) VAlUES ('" + startDate+ "', '"+ endDate+ "');";
		
		int result = 0;
		
		try {
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try(ResultSet generatedKeys = stmt.getGeneratedKeys()){
			if(generatedKeys.next()){
				result = generatedKeys.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		sql = "INSERT INTO Available(pid, hid, priceNight) Values('" + result+ "', '"+ houseID+ "', '" + priceNight + "')";
	
		try {
			stmt.executeUpdate(sql);
			changed = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return changed;
		
		
	}

	public boolean removeAvailability(String houseID, Statement stmt, String pid) {
		// TODO Auto-generated method stub
		boolean changed = false;

		String sql = "DELETE FROM Available WHERE hid = '" +houseID + "' AND pid = '" + pid+"';" ;
		
		try {
			stmt.executeUpdate(sql);
			changed = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return changed;
	}
	
	public boolean createChangeAvailability(String houseID, Statement stmt, String pid, String fromDate, String toDate, String priceNight){
		String sql = "UPDATE Available SET priceNight = '" + priceNight + "' WHERE hid = '" +houseID + "' AND pid = '" + pid+"';" ;
		boolean changed = false;
		try {
			stmt.executeUpdate(sql);
			sql = "UPDATE Period SET fromDate = '" + fromDate + "', toDate = '" +toDate+"' WHERE pid = '" + pid+"';" ;
			try{
				stmt.executeUpdate(sql);
				changed = true;
			}
			catch(SQLException e1){
				e1.printStackTrace();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return changed;
	}

	public List<Period> showAvailability(String houseID, Statement stmt){
		
		List<Period> results = new ArrayList<Period>();
		String sql = "SELECT A.pid, A.priceNight, P.fromDate, P.toDate FROM Available A, Period P WHERE A.hid = '"+houseID+"' AND P.pid = A.pid ;";
		ResultSet rs = null;
		
		
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				results.add(new Period(rs.getString("A.pid"), rs.getDate("P.fromDate").toString(), rs.getString("P.toDate").toString(), rs.getString("A.priceNight")));

				}
				
			}
			
		
		catch(SQLException e){
			e.printStackTrace();
		}
		
		return results;
	}

}
