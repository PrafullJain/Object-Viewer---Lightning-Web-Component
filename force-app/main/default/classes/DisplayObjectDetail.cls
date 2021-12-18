public class DisplayObjectDetail {
   
    @AuraEnabled(cacheable=true)
    public static List<Map<String,String>> customObjDetail(){
        List<Map<String,String>> allCustomObjsList = new List<Map<String,String>>();
        Map<String,String> mapCUSTOM= new Map<String,String>();

        for(Schema.SobjectType obj : Schema.getGlobalDescribe().values()) {
            Schema.DescribeSobjectResult objResult = obj.getDescribe();
            if(objResult.isCustom()) {
                String strObjName =objResult.getname();
                List<String> recordTypeArray = new List<String>();
                List<String> childRelationShipArray = new List<String>(); 
                mapCUSTOM.put('label',obj.getDescribe().getLabel());
                mapCUSTOM.put('apiName', obj.getDescribe().getName());
                if(obj.getDescribe().getChildRelationships()!= null){
                    for(schema.ChildRelationship ch: obj.getDescribe().getChildRelationships()){
                        childRelationShipArray.add(ch.getChildSObject().getDescribe().getLabel()+' ('+ch.getChildSObject().getDescribe().getName()+')');
                    }
                    mapCUSTOM.put('childRelationShips', string.join(childRelationShipArray,','));
                }
                if(obj.getDescribe().getRecordTypeInfos()!= null){
                    for(schema.RecordTypeInfo rt: obj.getDescribe().getRecordTypeInfos()){
                        recordTypeArray.add(rt.getName());
                    }
                    mapCUSTOM.put('recordTypes', string.join(recordTypeArray,','));
                }
              	allCustomObjsList.add(mapCUSTOM);
                mapCUSTOM= new Map<String,String>();
            }
            
        }
          
        System.debug('Custom Objects List: ' +allCustomObjsList);
        
        return allCustomObjsList; 
        
        
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String,String>> standardObjDetail(){
       List<Map<String,String>> allStandardObjsList = new List<Map<String,String>>();
        
        Map<String,String> mapSTD= new Map<String,String>();
        for(Schema.SobjectType obj : Schema.getGlobalDescribe().values()) {
            Schema.DescribeSobjectResult objResult = obj.getDescribe();
            if(objResult.isCustom() == false) {
               List<String> recordTypeArray = new List<String>();
               List<String> childRelationShipArray = new List<String>();
                mapSTD.put('label',obj.getDescribe().getLabel());
                mapSTD.put('apiName', obj.getDescribe().getName());
                if(obj.getDescribe().getChildRelationships()!= null){
                    for(schema.ChildRelationship ch: obj.getDescribe().getChildRelationships()){
                        childRelationShipArray.add(ch.getChildSObject().getDescribe().getLabel()+' ('+ch.getChildSObject().getDescribe().getName()+')');
                    }
                    mapSTD.put('childRelationShips', string.join(childRelationShipArray,','));
                }
                if(obj.getDescribe().getRecordTypeInfos()!= null){
                    for(schema.RecordTypeInfo rt: obj.getDescribe().getRecordTypeInfos()){
                        recordTypeArray.add(rt.getName());
                    }
                    mapSTD.put('recordTypes', string.join(recordTypeArray,','));
                }
              	allStandardObjsList.add(mapSTD);
                mapSTD= new Map<String,String>();
            }
        }
        return allStandardObjsList; 
    }
}