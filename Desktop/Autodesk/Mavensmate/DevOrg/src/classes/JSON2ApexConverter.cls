public class JSON2ApexConverter{
	public String jsonString = '{ "name":"John", "age":"30","billing":{"city":"SF","agh":{"flat":"5H"}}}';
	public Glossary apexObj{get;set;}
	public String str {get;set;}
	public PageReference getJSON(){
		apexObj = (Glossary)JSON.deserialize(jsonString, Glossary.class);
		System.debug('apexObj:'+apexObj);
		System.debug('apexObj:'+apexObj.billing);
		str=JSON.serialize(apexobj);
		return null;
	}
}