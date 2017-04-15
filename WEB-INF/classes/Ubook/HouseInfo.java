package Ubook;

public class HouseInfo {

	String houseID = null;
	String houseName = null;
	String houseCategory = null;
	String houseAddress = null;
	String houseURL = null;
	String houseNumber = null;
	String houseYear = null;
	String houseCity = null;
	String houseState = null;
	String houseOwner = null;
	String count = null;
	
	public HouseInfo(String id, String name, String category, String address, String url, String number,
			String year, String city, String state, String owner, String num) {
		// TODO Auto-generated constructor stub
		houseID = id;
		houseName = name;
		houseCategory = category;
		houseAddress = address;
		houseURL = url;
		houseNumber = number;
		houseYear = year;
		houseCity = city;
		houseState = state;
		houseOwner = owner;
		count = num;
	}
	
	public String getID(){
		return houseID;
		
	}
	
	public String getName(){
		return houseName;
		
	}
	public String getCategory(){
		return houseCategory;
		
	}
	public String getAddress(){
		return houseAddress;
		
	}
	public String getURL(){
		return houseURL;
		
	}
	public String getNumber(){
		return houseNumber;
		
	}
	public String getYear(){
		return houseYear;
		
	}
	public String getCity(){
		return houseCity;
		
	}
	public String getState(){
		return houseState;
		
	}
	public String getOwner(){
		return houseOwner;
		
	}
	
	public String getCount(){
		return count;
		
	}
}
