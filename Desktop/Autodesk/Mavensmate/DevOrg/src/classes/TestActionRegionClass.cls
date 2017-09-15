public class TestActionRegionClass{
    public List<Blob> dummyList{get;set;}
    public PageReference clickme() {
        for(Blob s: dummyList){
            System.debug('s:'+s);
        }
        return null;
    }

    public TestActionRegionClass(){
        dummyList = new List<Blob>();
        Blob s;
        for(Integer i = 0; i < 10; i++){
            dummyList.add(s);
        }
    }
}