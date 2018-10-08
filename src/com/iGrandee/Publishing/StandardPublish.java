package com.iGrandee.Publishing;

import java.util.ArrayList;
import java.util.HashMap;

import com.iGrandee.Common.CommonDataAccess;
//Referenced classes of package com.iGrandee.Common:
//CommonDataAccess
public class StandardPublish {
    public StandardPublish()
    {
        common_data_object = new CommonDataAccess();
        select_query = null;
        nameofcompany=null;
        nameofperson=null;
        location=null;
        email=null;
    }

    public String getYearOfSession()
    {
        //System.out.println("getYearOfSession");

        String s = "";
        try
        {
            select_query = "select distinct sessionid,sessionname from kycportal.yearofsession where sessionstatus='A'";
            //System.out.println("select_query"+select_query);
            s = common_data_object.getRecordAsString(select_query);
            //System.out.println("select_query"+select_query+"--s-->"+select_query);
        }
        catch(Exception exception) { }
        return s;
    }


	
 public int checkUser(String s, String s1)
    {
        int i = 0;
        try
        {
            ArrayList arraylist = null;
            select_query = "select * from login where username='"+s+"'";
            //System.out.println(select_query);
            arraylist = common_data_object.getListMap(select_query);
            //System.out.println(arraylist);
            if(arraylist != null && arraylist.size() > 0)
            {
                i = 1;
            }
            select_query = null;
        }
        catch(Exception exception) { }
        return i;
    }
 
 public int checkPassword(String s, String s1, String s2)
 {
     int byte0 = 1;
     try
     {
         ArrayList arraylist = null;
         if(s2.equals("login"))
//             select_query = "select username,loginid,usercategory,password from login where username='"+s+"' and password='"+s1+"'";
        	 select_query = "SELECT a.username,a.loginid,a.usercategory,b.nameofcompany,b.nameofperson,b.location,b.email FROM login a,registrationinfo b where a.username='"+s+"' and a.regid=b.regid and a.password='"+s1+"' and a.loginstatus='A'";
         arraylist = common_data_object.getListMap(select_query);
         //System.out.println(arraylist);
         if(arraylist != null && arraylist.size() > 0)
         {
             HashMap hashmap = (HashMap)arraylist.get(0);
             byte0 = 2;
             username = (String)hashmap.get("username");
             userid = (String)hashmap.get("loginid");
             category = (String)hashmap.get("usercategory");
             nameofcompany = (String)hashmap.get("nameofcompany");
             nameofperson = (String)hashmap.get("nameofperson");
             location = (String)hashmap.get("location");
             email = (String)hashmap.get("email");
         }
     }
     catch(Exception exception) { 
    	 
    	 exception.printStackTrace();
     }
     return byte0;
 }
 
 
 
 
 public String getuserid()
 {
     return userid;
 }

 public String getcategory()
 {
     return category;
 }
 
 public String getnameofcompany()
 {
     return nameofcompany;
 }
 
 public String getnameofperson()
 {
     return nameofperson;
 }
 
 public String getlocation()
 {
     return location;
 }
 
 public String getemail()
 {
     return email;
 }
 
 
 CommonDataAccess common_data_object;
 String select_query;
 String userid;
 String category;
 String username;
 String nameofcompany;
 String nameofperson;
 String location;
 String email;
}