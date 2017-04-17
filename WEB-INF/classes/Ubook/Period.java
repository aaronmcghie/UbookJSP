package Ubook;

public class Period {
	
	String lPid = null;
	
	String lFrom = null;
	
	String lTo = null;
	
	String lPrice = null;

	public Period(String pid, String fromDate, String toDate, String price) {
		// TODO Auto-generated constructor stub
		
		lPid = pid;
		
		lFrom = fromDate;
		
		lTo = toDate;
		
		lPrice = price;
	}
	
	public String getPID(){
		return lPid;
	}
	
	public String getFrom(){
		return lFrom;
		
	}
	
	public String getTo(){
		return lTo;
	}
	
	public String getPrice(){
		return lPrice;
	}
}
