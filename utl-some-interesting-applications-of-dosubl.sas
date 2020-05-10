Three interesting applications of dosubl                                                                
                                                                                                        
   a. subset sashelp.class where the age is less than the median age in another datasets                
   b. set a dynamic filtered dataset                                                                    
   c. convert all missing values in an  to 0 and counting the number of zeroes                          
                                                                                                        
                                                                                                        
github                                                                                                  
https://tinyurl.com/yceuan7w                                                                            
https://github.com/rogerjdeangelis/utl-some-interesting-applications-of-dosubl                          
                                                                                                        
*         _                     _        _     _                                                        
__      _| |__   ___ _ __ ___  | |_ __ _| |__ | | ___                                                   
\ \ /\ / / '_ \ / _ \ '__/ _ \ | __/ _` | '_ \| |/ _ \                                                  
 \ V  V /| | | |  __/ | |  __/ | || (_| | |_) | |  __/                                                  
  \_/\_/ |_| |_|\___|_|  \___|  \__\__,_|_.__/|_|\___|                                                  
                                                                                                        
;                                                                                                       
                                                                                                        
* subset sashelp.class where age is less than the mean in sashelp.classfit;                             
                                                                                                        
data class_subset;                                                                                      
                                                                                                        
   set sashelp.class                                                                                    
                                                                                                        
     (where=(age <= %dosubl('                                                                           
       proc sql;                                                                                        
          select                                                                                        
            median(age) into :_age                                                                      
          from                                                                                          
            sashelp.classfit                                                                            
          ;quit;                                                                                        
       ')                                                                                               
        &_age                                                                                           
     ));                                                                                                
                                                                                                        
run;quit;                                                                                               
                                                                                                        
*         _         _                             _                                                     
 ___  ___| |_    __| |_   _ _ __   __ _ _ __ ___ (_) ___                                                
/ __|/ _ \ __|  / _` | | | | '_ \ / _` | '_ ` _ \| |/ __|                                               
\__ \  __/ |_  | (_| | |_| | | | | (_| | | | | | | | (__                                                
|___/\___|\__|  \__,_|\__, |_| |_|\__,_|_| |_| |_|_|\___|                                               
                      |___/                                                                             
;                                                                                                       
                                                                                                        
* set a subset of sashelp.class;                                                                        
                                                                                                        
data class_subset;                                                                                      
                                                                                                        
   set %dosubl('                                                                                        
      proc sql;                                                                                         
       create                                                                                           
          table subset as                                                                               
       select                                                                                           
          name                                                                                          
         ,age                                                                                           
         ,sex                                                                                           
         ,height as heightInch                                                                          
      from                                                                                              
          sashelp.class                                                                                 
      where                                                                                             
          age > 12                                                                                      
      ;quit;                                                                                            
      %let dsn=subset;                                                                                  
     ')                                                                                                 
      &dsn;                                                                                             
                                                                                                        
     heightCm = 2.54 * heightInch;                                                                      
                                                                                                        
run;quit;                                                                                               
                                                                                                        
*          _           _                                                                                
 _ __ ___ (_)___ ___  | |_ ___    _______ _ __ ___                                                      
| '_ ` _ \| / __/ __| | __/ _ \  |_  / _ \ '__/ _ \                                                     
| | | | | | \__ \__ \ | || (_) |  / /  __/ | | (_) |                                                    
|_| |_| |_|_|___/___/  \__\___/  /___\___|_|  \___/                                                     
                                                                                                        
;                                                                                                       
                                                                                                        
data have;                                                                                              
 input x1-x5;                                                                                           
cards4;                                                                                                 
2 . 2 2 2                                                                                               
1 . . 1 .                                                                                               
1 1 . 2 .                                                                                               
. 1 5 . .                                                                                               
;;;;                                                                                                    
run;quit;                                                                                               
                                                                                                        
WORK.HAVE total obs=4                                                                                   
                                                                                                        
  x1    x2    x3    x4    x5                                                                            
                                                                                                        
   2     .     2     2     2                                                                            
   1     .     .     1     .                                                                            
   1     1     .     2     .                                                                            
   .     1     5     .     .                                                                            
                                                                                                        
data want;                                                                                              
                                                                                                        
  set %dosubl('                                                                                         
     proc stdize out=have reponly missing=0;                                                            
     run;quit;                                                                                          
     ')                                                                                                 
     have;                                                                                              
                                                                                                        
     array xs[*] x1-x5;                                                                                 
     length cs $40;                                                                                     
                                                                                                        
      * move the numeric array into a string;                                                           
                                                                                                        
      call pokelong( peekclong(addrlong(xs[1]),40), addrlong(cs), 40 );                                 
      * count zeros;                                                                                    
      zroCnt=count(cs,put(0,rb8.));                                                                     
                                                                                                        
      put zroCnt=;                                                                                      
      drop cs;                                                                                          
run;quit;                                                                                               
                                                                                                        
Up to 40 obs from WANT total obs=4                                                                      
                                                                                                        
                                     zro                                                                
Obs    x1    x2    x3    x4    x5    Cnt                                                                
                                                                                                        
 1      2     0     2     2     2     1                                                                 
 2      1     0     0     1     0     3                                                                 
 3      1     1     0     2     0     2                                                                 
 4      0     1     5     0     0     3                                                                 
                                                                                                        
                                                                                                        
                                                                                                        
