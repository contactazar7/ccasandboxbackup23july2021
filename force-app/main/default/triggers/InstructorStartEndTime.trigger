trigger InstructorStartEndTime on Instructor__c (before insert,before update) {
     
/*        for(Instructor__c i : trigger.new){
            
            if(string.isNotBlank(i.Monday_Available_time__c)){
                
                List<String> splitSize = i.Monday_Available_time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                i.Monday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                
                i.Monday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Tuesday_Available_Time__c)){
                
                List<String> splitSize = i.Tuesday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                i.Tuesday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                
                i.Tuesday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Wednesday_Available_Time__c)){
                
                List<String> splitSize = i.Wednesday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                i.Wednesday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                
                i.Wednesday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Thursday_Available_Time__c)){
                
                List<String> splitSize = i.Thursday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                i.Thursday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                
                i.Thursday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Friday_Available_Time__c)){
                
                List<String> splitSize = i.Friday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                i.Friday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                
                i.Friday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Saturday_Available_Time__c)){
                
                List<String> splitSize = i.Saturday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                i.Saturday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                
                i.Saturday_End_Time__c = str4;
                
            }
            
            
        }
    
*/
    
    
     for(Instructor__c i : trigger.new){
            
            if(string.isNotBlank(i.Monday_Available_Time__c)){
                
                List<String> splitSize = i.Monday_Available_time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                if(string.isNotBlank(str2)){
                  string tm =  str2.contains('PM') ? str2.remove('PM')  : str2.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = str2.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    i.Monday_Start_Time__c = myTime;
                }

                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                
                if(string.isNotBlank(str4)){
                    string  tm =  str4.contains('PM') ? str4.remove('PM')  : str4.remove('AM');
                     
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                     integer PmShift = str4.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                     
                    Time myTime = Time.newInstance(hrs+PmShift , Integer.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]), 0, 0);
                    i.Monday_End_Time__c = myTime;
                }
                
                
                
            }
            if(string.isNotBlank(i.Tuesday_Available_Time__c)){
                
                List<String> splitSize = i.Tuesday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                   if(string.isNotBlank(str2)){
                       string tm =  str2.contains('PM') ? str2.remove('PM')  : str2.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = str2.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    i.Tuesday_Start_Time__c = myTime;
                }
               // i.Tuesday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                if(string.isNotBlank(str4)){
                     string  tm =  str4.contains('PM') ? str4.remove('PM')  : str4.remove('AM');
                     
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                     integer PmShift = str4.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                     
                    Time myTime = Time.newInstance(hrs+PmShift , Integer.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]), 0, 0);
                    
                    i.Tuesday_End_Time__c = myTime;
                }
               // i.Tuesday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Wednesday_Available_Time__c)){
                
                List<String> splitSize = i.Wednesday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
              if(string.isNotBlank(str2)){
                   string tm =  str2.contains('PM') ? str2.remove('PM')  : str2.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = str2.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    i.Wednesday_Start_Time__c = myTime;
                }
              //  i.Wednesday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                if(string.isNotBlank(str4)){
                    string  tm =  str4.contains('PM') ? str4.remove('PM')  : str4.remove('AM');
                     
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                     integer PmShift = str4.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                     
                    Time myTime = Time.newInstance(hrs+PmShift , Integer.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]), 0, 0);
                    
                    i.Wednesday_End_Time__c = myTime;
                }
               // i.Wednesday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Thursday_Available_Time__c)){
                
                List<String> splitSize = i.Thursday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
               if(string.isNotBlank(str2)){
                    string tm =  str2.contains('PM') ? str2.remove('PM')  : str2.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = str2.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    i.Thursday_Start_Time__c = myTime;
                }
               // i.Thursday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                 if(string.isNotBlank(str4)){
                      string  tm =  str4.contains('PM') ? str4.remove('PM')  : str4.remove('AM');
                     
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                     integer PmShift = str4.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                     
                    Time myTime = Time.newInstance(hrs+PmShift , Integer.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]), 0, 0);
                    
                    i.Thursday_End_Time__c = myTime;
                }
               // i.Thursday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Friday_Available_Time__c)){
                
                List<String> splitSize = i.Friday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
            if(string.isNotBlank(str2)){
               string tm =  str2.contains('PM') ? str2.remove('PM')  : str2.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = str2.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    i.Friday_Start_Time__c = myTime;
                }
               // i.Friday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                 if(string.isNotBlank(str4)){
                      string  tm =  str4.contains('PM') ? str4.remove('PM')  : str4.remove('AM');
                     
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                     integer PmShift = str4.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                     
                    Time myTime = Time.newInstance(hrs+PmShift , Integer.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]), 0, 0);
                    
                    i.Friday_End_Time__c = myTime;
                }
              //  i.Friday_End_Time__c = str4;
                
            }
            if(string.isNotBlank(i.Saturday_Available_Time__c)){
                
                List<String> splitSize = i.Saturday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                  if(string.isNotBlank(str2)){
                      string tm =  str2.contains('PM') ? str2.remove('PM')  : str2.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = str2.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    i.Saturday_Start_Time__c = myTime;
                }
               // i.Saturday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                 if(string.isNotBlank(str4)){
                     string  tm =  str4.contains('PM') ? str4.remove('PM')  : str4.remove('AM');
                     
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                     integer PmShift = str4.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                     
                    Time myTime = Time.newInstance(hrs+PmShift , Integer.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]), 0, 0);
                    
                    i.Saturday_End_Time__c = myTime;
                }
                //i.Saturday_End_Time__c = str4;
                
            } 
                  if(string.isNotBlank(i.Sunday_Available_Time__c)){
                
                List<String> splitSize = i.Sunday_Available_Time__c.split(';');
                
                string str1= splitSize[0];
                string str2 = str1.split('-')[0];
                  if(string.isNotBlank(str2)){
                      string tm =  str2.contains('PM') ? str2.remove('PM')  : str2.remove('AM');
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                       integer mit= Double.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]).intValue();
                      integer PmShift = str2.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                    Time myTime = Time.newInstance(hrs+PmShift, mit, 0, 0);
                    i.Sunday_Start_Time__c = myTime;
                }
               // i.Saturday_Start_Time__c = str2;
                
                string str3= splitSize[splitSize.size()-1];
                string str4 = str3.split('-')[1];
                 if(string.isNotBlank(str4)){
                     string  tm =  str4.contains('PM') ? str4.remove('PM')  : str4.remove('AM');
                     
                     integer hrs = Double.valueOf(tm.split(':')[0]).intValue();
                     integer PmShift = str4.contains('PM') ? ( hrs== 12 ? 24 : 12) : 0;
                     
                    Time myTime = Time.newInstance(hrs+PmShift , Integer.valueOf(tm.split(':')[1].contains('00') ? '0':tm.split(':')[1]), 0, 0);
                    
                    i.Sunday_End_Time__c = myTime;
                }
                //i.Saturday_End_Time__c = str4;
                
            } 
            
        } 
}