package Ubook;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Stats {

	public List<HouseInfo> popularTH(String amount, Statement stmt) {
		// TODO Auto-generated method stub
		List<HouseInfo> results = new ArrayList<HouseInfo>();
		
		String sql = "SELECT V.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login, COUNT(V.hid) AS houseCount FROM "
				+ "Visits V, TH T WHERE V.hid = T.hid GROUP BY V.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login ORDER BY houseCount DESC "
				+ "LIMIT " + amount + ";" ;
		
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			
			
			while(rs.next()){
				results.add(new HouseInfo(rs.getString("V.hid"),rs.getString("T.name"),rs.getString("T.category"),rs.getString("T.address"),rs.getString("T.city"),rs.getString("T.state"),rs.getString("T.yearBuilt"),rs.getString("T.phoneNumber"),rs.getString("T.URL"),rs.getString("T.login"), rs.getString("houseCount")));

			}
			}
		 catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return results;
	}

	public List<HouseInfo> expensiveTH(String amount, Statement stmt) {
		// TODO Auto-generated method stub
		List<HouseInfo> results = new ArrayList<HouseInfo>();
		String sql = "SELECT V.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login, AVG(V.cost) AS costAVG FROM "
				+ "Visits V, TH T WHERE V.hid = T.hid GROUP BY V.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login ORDER BY costAVG DESC "
				+ "LIMIT " + amount + ";" ;
		
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				results.add(new HouseInfo(rs.getString("V.hid"),rs.getString("T.name"),rs.getString("T.category"),rs.getString("T.address"),rs.getString("T.city"),rs.getString("T.state"),rs.getString("T.yearBuilt"),rs.getString("T.phoneNumber"),rs.getString("T.URL"),rs.getString("T.login"), rs.getString("costAVG")));
			}
			}
		 catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return results;
	}

	public List<HouseInfo> ratedTH(String amount, Statement stmt) {
		// TODO Auto-generated method stub
		String sql = "SELECT DISTINCT T.category FROM TH T ORDER BY T.category";
		List<String> categories = new ArrayList<String>();
		ResultSet rs = null;
		List<HouseInfo> results = new ArrayList<HouseInfo>();
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				categories.add(rs.getString("T.category"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		for(int i = 0; i < categories.size(); i++){
			sql = "SELECT F.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login, AVG(F.score) AS scoreAVG FROM "
					+ "Feedback F, TH T WHERE F.hid = T.hid AND T.category = '"+categories.get(i)+"' GROUP BY F.hid, T.name, T.category, T.address, T.URL, T.phoneNumber, T.yearBuilt, T.city, T.state, T.login ORDER BY scoreAVG DESC "
					+ "LIMIT " + amount + ";" ;
			
			try {
				rs = stmt.executeQuery(sql);
				
				while(rs.next()){
					results.add(new HouseInfo(rs.getString("F.hid"),rs.getString("T.name"),rs.getString("T.category"),rs.getString("T.address"),rs.getString("T.city"),rs.getString("T.state"),rs.getString("T.yearBuilt"),rs.getString("T.phoneNumber"),rs.getString("T.URL"),rs.getString("T.login"), rs.getString("scoreAVG")));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
			
		}
		return results;
	}

}
