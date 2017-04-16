package Ubook;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Keyword {

//	public void setUp(String houseID, Statement stmt) {
//		// TODO Auto-generated method stub
//		String ID = houseID;
//		while(ID != null){
//			System.out.println("Press 1 to view keywords for the house");
//			System.out.println("Press 2 add keywords for the house");
//			System.out.println("Press 3 to remove keywords for the house.");
//			System.out.println("Press 4 to exit.");
//			String choice = null;
//			try {
//				choice = MainMenu.input.readLine();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			
//			switch(choice){
//			case "1":
//				viewKeyWords(ID, stmt);
//				break;
//			case "2":
//				addKeyWords(ID,stmt);
//				break;
//			case "3":
//				removeKeyWords(ID,stmt);
//				break;
//			case "4":
//				ID = null;
//				break;
//			default:
//				System.out.println("That is not a valid choice, please try again.");
//				break;
//			}
//		
//		}
//		System.out.println("Exiting Keyword Menu. \n");
//	}

	public boolean removeKeyWords(String ID, Statement stmt, String wid) {
		// TODO Auto-generated method stub
		
		boolean done = false;
				
		ResultSet rs2;
		String sql = "DELETE FROM HasKeywords WHERE wid = '"+wid+"' AND hid = '"+ID+"';";
					
		try {
			stmt.executeUpdate(sql);
			done = true;
			}
			
		 catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return done;
	}

	public boolean addKeyWords(String ID, Statement stmt, String word, String language) {
		// TODO Auto-generated method stub
	
		boolean done = false;
				String wid = null;
					String sql = "Select wid from Keywords WHERE word = '"+word+"' AND language = '"+language+"';";
					ResultSet rs;
					try {
						rs = stmt.executeQuery(sql);
						if(rs.isBeforeFirst()){
							while(rs.next()){
								wid = rs.getString(1);
							}
						}
						else{
							sql = "INSERT INTO Keywords(word, language) VALUES('"+word+"', '"+language+"');";
							
							try {
								stmt.executeUpdate(sql);
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							try(ResultSet generatedKeys = stmt.getGeneratedKeys()){
								if(generatedKeys.next()){
									wid = generatedKeys.getString(1);
								}
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
						
						sql = "INSERT INTO HasKeywords(hid, wid) VALUES('"+ID+"','"+wid+ "');";
						
						try {
							stmt.executeUpdate(sql);
							done = true;
							
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				return done;

	}

	public  List<Keys> viewKeyWords(String ID, Statement stmt) {
		List<Keys> results = new ArrayList<Keys>();
		String sql = "SELECT H.wid, K.word, K.language FROM HasKeywords H, Keywords K WHERE H.wid = K.wid AND H.hid = '" + ID + "';";
		ResultSet rs = null;
		try {
			rs = stmt.executeQuery(sql);

				while(rs.next()){
					
					results.add(new Keys(rs.getString("H.wid"), rs.getString("K.word"), rs.getString("K.language")));
					
					}
			}
			catch(SQLException e){
				e.printStackTrace();
			}
		return results;
		}
	
}

