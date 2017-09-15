public class AsciiConverterController{
	public String inputString{get;set;}
	public String outputString{get;set;}
	public AsciiConverterController(){			
	}
	public PageReference findAscii(){
		try{
			outputString = '';
			for(Integer i = 0; i < inputString.length(); i++){
				String s = ''+inputString.substring(i,i+1);
				outputString += (s+'->'+Integer.valueOf(inputString.charAt(i))+'\n');
			}
		}catch(Exception e){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, e.getMessage()));
		}
		return null;
	}

}