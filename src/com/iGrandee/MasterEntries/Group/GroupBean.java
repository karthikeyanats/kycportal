package com.iGrandee.MasterEntries.Group;

public class GroupBean
{
    public GroupBean()
    {
    }//grouplogid, groupid, grouplogdetail, createdby, dateofcreation, grouplogstatus
//groupid, groupname, description, createdby, instituteid, dateofcreation, groupstatus
    public void setOperation(String s)
    {
        operation = s;
    }

    public String getOperation()
    {
        return operation;
    }
    
    public void setgroupid(String s)
    {
        groupid = s;
    }
    
    public String getgroupid()
    {
        return groupid;
    }
    public void setboardid(String s)
    {
    	boardid = s;
    }
    
    public String getboardid()
    {
        return boardid;
    }
    public void setgroupname(String s)
    {
    	groupname = s;
    }
    public String getgroupname()
    {
        return groupname;
    }
    
    public void setDescription(String s)
    {
    	description = s;
    }

    public String getDescription()
    {
        return description;
    }
    
    
    public void setgroupstatus(String s)
    {
    	groupstatus = s;
    }

    public String getgroupstatus()
    {
        return groupstatus;
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
    public void setgrouplogstatus(String s)
    {
    	grouplogstatus = s;
    }

    public String getgrouplogstatus()
    {
        return grouplogstatus;
    }
    public void setgetgrouplogdetail(String s)
    {
    	setgetgrouplogdetail = s;
    }

    public String getgetgrouplogdetail()
    {
        return setgetgrouplogdetail;
    }
    private static String operation = null;
    private static String groupid = null;
    private static String groupname = null;

    private static String description = null;
    private static String groupstatus = null;
    private static String ipaddress = null;
    private static String CreatedBy = null;
    private static String instituteid = null;
    private static String grouplogstatus = null;
    private static String boardid = null;
    private static String setgetgrouplogdetail = null;




    
}