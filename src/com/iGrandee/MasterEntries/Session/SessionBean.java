package com.iGrandee.MasterEntries.Session;

public class SessionBean
{
    public SessionBean()
    {
    }
    public void setOperation(String s)
    {
        operation = s;
    }

    public String getOperation()
    {
        return operation;
    }
    public void setsessionid(String s)
    {
        sessionid = s;
    }
    
    public String getsessionid()
    {
        return sessionid;
    }
    public void setsubjecttypelogid(String s)
    {
    	subjecttypelogid = s;
    }
    
    public String getsubjecttypelogid()
    {
        return subjecttypelogid;
    }
   
    public void setsessionname(String s)
    {
    	sessionname = s;
    }
    public String getsessionname()
    {
        return sessionname;
    }
    
    public void setDescription(String s)
    {
    	description = s;
    }

    public String getDescription()
    {
        return description;
    }
    
    
    public void setsessionstatus(String s)
    {
    	sessionstatus = s;
    }

    public String getsessionstatus()
    {
        return sessionstatus;
    }
    
    
    public void setIpaddess(String s)
    {
    	ipaddress = s;
    }

    public String getIpaddess()
    {
        return ipaddress;
    }
    public void setCreatedBy(String s)
    {
    	CreatedBy = s;
    }

    public String getCreatedBy()
    {
        return CreatedBy;
    
    }
    public void setinstituteid(String s)
    {
    	instituteid = s;
    }

    public String getinstituteid()
    {
        return instituteid;
    }
   
    public void setsubjecttypelogstatus(String s)
    {
    	subjecttypelogstatus = s;
    }

    public String getsubjecttypelogstatus()
    {
        return subjecttypelogstatus;
    }
    public void setlogdetails(String s)
    {
    	logdetails = s;
    }

    public String getlogdetails()
    {
        return logdetails;
    }
   
    private static String operation = null;
    private static String sessionid = null;
    private static String sessionname = null;

    private static String description = null;
    private static String sessionstatus = null;
    private static String ipaddress = null;
    private static String CreatedBy = null;
    private static String instituteid = null;
    private static String logdetails = null;
    private static String subjecttypelogid = null;
    private static String subjecttypelogstatus = null;
}



    
