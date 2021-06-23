trigger updateTimeFieldsBasedonPicklistValue on SFDC_Class__c (before insert, before Update) {
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        for(SFDC_Class__c s : trigger.new){
           
            
            if(string.isNotBlank(s.Monday_Start_Time1__c)){
                 string tm = s.Monday_Start_Time1__c.contains('PM') ? s.Monday_Start_Time1__c.remove('PM')  : s.Monday_Start_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Monday_Start_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    s.Monday_Start_Time__c = myTime;
            }
            
            if(string.isNotBlank(s.Monday_End_Time2__c)){
               string tm = s.Monday_End_Time2__c.contains('PM') ? s.Monday_End_Time2__c.remove('PM')  : s.Monday_End_Time2__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Monday_End_Time2__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Monday_End_Time__c = myTime;
            }
            
            
             if(string.isNotBlank(s.Tuesday_Start_Time1__c)){
               string tm = s.Tuesday_Start_Time1__c.contains('PM') ? s.Tuesday_Start_Time1__c.remove('PM')  : s.Tuesday_Start_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Tuesday_Start_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Tuesday_Start_Time__c = myTime;
            }
            
             if(string.isNotBlank(s.Tuesday_End_Time2__c)){
               string tm = s.Tuesday_End_Time2__c.contains('PM') ? s.Tuesday_End_Time2__c.remove('PM')  : s.Tuesday_End_Time2__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Tuesday_End_Time2__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Tuesday_End_Time__c = myTime;
            }
            
            if(string.isNotBlank(s.Wednesday_Start_Time1__c)){
             string tm = s.Wednesday_Start_Time1__c.contains('PM') ? s.Wednesday_Start_Time1__c.remove('PM')  : s.Wednesday_Start_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Wednesday_Start_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Wednesday_Start_Time__c = myTime;
            }
            
            if(string.isNotBlank(s.Wednesday_End_Time2__c)){
                 string tm = s.Wednesday_End_Time2__c.contains('PM') ? s.Wednesday_End_Time2__c.remove('PM')  : s.Wednesday_End_Time2__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Wednesday_End_Time2__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Wednesday_End_Time__c = myTime;
            }
            
            if(string.isNotBlank(s.Thursday_Start_Time1__c)){
             string tm = s.Thursday_Start_Time1__c.contains('PM') ? s.Thursday_Start_Time1__c.remove('PM')  : s.Thursday_Start_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Thursday_Start_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Thursday_Start_Time__c = myTime;
            }
            
            if(string.isNotBlank(s.Thursday_End_Time2__c)){
                string tm = s.Thursday_End_Time2__c.contains('PM') ? s.Thursday_End_Time2__c.remove('PM')  : s.Thursday_End_Time2__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Thursday_End_Time2__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Thursday_End_Time__c = myTime;
            }
            
             if(string.isNotBlank(s.Friday_Start_Time1__c)){
                string tm = s.Friday_Start_Time1__c.contains('PM') ? s.Friday_Start_Time1__c.remove('PM')  : s.Friday_Start_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Friday_Start_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Friday_Start_Time__c = myTime;
            }
                        
            if(string.isNotBlank(s.Friday_End_Time2__c)){
                 string tm = s.Friday_End_Time2__c.contains('PM') ? s.Friday_End_Time2__c.remove('PM')  : s.Friday_End_Time2__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Friday_End_Time2__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Friday_End_Time__c = myTime;
            }
            
            if(string.isNotBlank(s.Saturday_Start_Time1__c)){
                string tm = s.Saturday_Start_Time1__c.contains('PM') ? s.Saturday_Start_Time1__c.remove('PM')  : s.Saturday_Start_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Saturday_Start_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Saturday_Start_Time__c = myTime;
            }
            if(string.isNotBlank(s.Saturday_End_Time2__c)){
              string tm = s.Saturday_End_Time2__c.contains('PM') ? s.Saturday_End_Time2__c.remove('PM')  : s.Saturday_End_Time2__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Saturday_End_Time2__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.Saturday_End_Time__c = myTime;
            }
        }
    }
    
    
    //Classtimeings
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        for(SFDC_Class__c s : trigger.new){
           
            
            if(string.isNotBlank(s.Start_Time1__c)){
                 string tm = s.Start_Time1__c.contains('PM') ? s.Start_Time1__c.remove('PM')  : s.Start_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.Start_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) : ( hrs== 12 ? 12 : 24);
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    s.Start_Time__c = myTime;
            }
            
            if(string.isNotBlank(s.End_Time1__c)){
               string tm = s.End_Time1__c.contains('PM') ? s.End_Time1__c.remove('PM')  : s.End_Time1__c.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = s.End_Time1__c.contains('PM') ? ( hrs== 12 ? 24 : 12) :( hrs== 12 ? 12 : 24);
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                s.End_Time__c = myTime;
            }
            
        }
    }

}