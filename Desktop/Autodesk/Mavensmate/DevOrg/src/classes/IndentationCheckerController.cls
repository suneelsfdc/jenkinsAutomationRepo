public class IndentationCheckerController{
	public String inputString{get;set;}
	public String outputString{get;set;}
	List<String> chars;
	String leadingTabs;
	public IndentationCheckerController(){			
	}
	public PageReference beautifyCode(){
		try{
			inputString = inputString.replaceAll( '\\s+', ' ');
			chars = new List<String>();
			chars = inputString.split('');
			outputString = '';
			leadingTabs = '';			

			for(Integer i = 0; i < chars.size(); i++){
				if(i != 0 && chars[i-1] != '}' && chars[i] == '}'){
					outputString = addEnter();
				}				
				if(chars[i] == '}'){
					leadingTabs = leadingTabs.substringBeforeLast('\t');
					outputString += leadingTabs;
				}				
				outputString += chars[i];
				if(chars[i] == ';' || chars[i] == '{' || chars[i] == '}'){
					outputString = addEnter();
				}	
				if(chars[i] == '{'){
					leadingTabs += '\t';
					outputString += leadingTabs;
				}
							
			}
			//outputString = inputString;
		}catch(Exception e){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, e.getMessage()));
		}
		return null;
	}
	public String addEnter(){
		return outputString+'\n';
	}

}