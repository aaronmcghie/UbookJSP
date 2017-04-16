package Ubook;

public class Keys {

	public String lWid = null;
	public String lWord = null;
	public String lLanguage = null;
	public Keys(String wid, String word, String language) {
		// TODO Auto-generated constructor stub
		lWid = wid;
		lWord = word;
		lLanguage = language;
	}
	
	public String getWid(){
		return lWid;
		
	}
	
	public String getWord(){
		return lWord;
	}
	
	public String getLanguage(){
		return lLanguage;
	}

}
