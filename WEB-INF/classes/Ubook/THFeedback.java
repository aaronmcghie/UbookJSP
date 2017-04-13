package Ubook;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class THFeedback {
	public boolean thReview(String userName, Statement stmt, String TH, String text, String score) {
		// TODO Auto-generated method stub

		boolean done = false;
		
		ResultSet rs = null;
		String sql = null;
		
		Stay stayedAt = new Stay();
		
		
		
		TH verifyHouse = new TH();
		
		String houseID = null;

		
		houseID = verifyHouse.verifyHouseID(userName, TH,stmt);
		
		if(houseID == null){

			houseID = stayedAt.verifyStay(userName, TH, stmt);
			
			if(houseID != null){
				sql = "SELECT F.fid from Feedback F where F.hid = '" +houseID+ "' AND F.login = '" + userName+ "';";
				boolean ratedBefore = false;
				try {
					rs = stmt.executeQuery(sql);
					if(rs.isBeforeFirst()){
						ratedBefore = true;
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}		
				
				if(!ratedBefore){
					java.util.Date dt = new java.util.Date();
					
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					String currentTime = sdf.format(dt);		
						sql = "INSERT INTO Feedback(score, text, hid, login, fbdate) VALUES('"+score+"', "
								+ "'"+text+"', '"+houseID+"', '"+userName+"', '"+currentTime+"')";
						
						try {
							stmt.executeUpdate(sql);
							done = true;
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}

			}
		
		
		
		return done;
	}
	
	public List<reviewedFeedback> viewMostUsefulFeedback(String amount, Statement stmt, String THID){
		
		
		
		String sql = "SELECT F.fid, F.score, F.text, F.login, F.fbdate, AVG(R.rating) avg_score FROM Feedback F, Rates R "
				+ "WHERE F.fid = R.fid AND F.hid = "+THID+" GROUP BY F.fid, F.score, F.text, F.login, F.fbdate ORDER BY avg_score DESC LIMIT "+amount+";";
		
		ResultSet rs = null;
		
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		List<reviewedFeedback> items = new ArrayList<reviewedFeedback>();
		
		try {
			while(rs.next()){
				items.add(new reviewedFeedback(rs.getString("fid"),rs.getString("score"), rs.getString("text"), rs.getString("login")
						, rs.getString("fbdate"), rs.getString("avg_score")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(items.size() < Integer.parseInt(amount)){
			sql = "SELECT F.fid, F.score, F.text, F.login, F.fbdate FROM Feedback F "
					+ "WHERE F.hid = "+THID+" AND F.fid NOT IN (SELECT fid from 5530db34.Rates) group by F.fid, F.score, F.text, F.login, F.fbdate ORDER BY F.fid DESC "
					+ "LIMIT "+Integer.toString(Integer.parseInt(amount) - items.size())+";";
			
			try {
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					
					items.add(new reviewedFeedback(rs.getString("fid"),rs.getString("score"), rs.getString("text"), rs.getString("login")
							, rs.getString("fbdate"), "0"));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return items;
	}

	public boolean reviewFeedback(String userName, Statement stmt, String feedbackID, String score) {
		String sql = "SELECT F.login FROM Feedback F where F.fid = '"+feedbackID+"' AND F.login = '"+userName+"';";
		ResultSet rs = null;
		boolean ratedBefore = false;
		boolean done = false;
		
		try {
			rs = stmt.executeQuery(sql);
			if(rs.isBeforeFirst()){
				
				ratedBefore = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(!ratedBefore){
			sql = "SELECT R.fid from Rates R where R.fid = '" +feedbackID+ "' AND R.login = '" + userName+ "';";
			
			try {
				rs = stmt.executeQuery(sql);
				if(rs.isBeforeFirst()){
					
					ratedBefore = true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(!ratedBefore){		
			sql = "INSERT INTO Rates(login, fid, rating) VALUES('"+userName+"', "
					+ "'"+feedbackID+"', '"+score+"')";
			
			try {
				stmt.executeUpdate(sql);
				done = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return done;
	}
}
