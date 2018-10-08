package com.iGrandee.MasterEntries.Role;


public class RoleBean
{

    public RoleBean()
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
    
    public void setRoleid(String s)
    {
        departmentid = s;
    }
    
    public String getRoleid()
    {
        return departmentid;
    }
    public void setRolename(String s)
    {
    	departmentname = s;
    }
    public String getRolename()
    {
        return departmentname;
    }
    
    public void setrDescription(String s)
    {
    	description = s;
    }

    public String getDescription()
    {
        return description;
    }
    
    
    public void setStatus(String s)
    {
    	status = s;
    }

    public String getStatus()
    {
        return status;
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
    public void setlogstatus(String s)
    {
    	logstatus = s;
    }

    public String getlogstatus()
    {
        return logstatus;
    }
    private static String operation = null;
    private static String departmentid = null;
    private static String departmentname = null;

    private static String description = null;
    private static String status = null;
    private static String ipaddress = null;
    private static String CreatedBy = null;
    private static String instituteid = null;
    private static String logstatus = null;


    
}