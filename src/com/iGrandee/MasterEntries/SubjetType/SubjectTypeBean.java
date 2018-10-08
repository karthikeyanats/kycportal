package com.iGrandee.MasterEntries.SubjetType;

public class SubjectTypeBean
{
    public SubjectTypeBean()
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
  //subjecttypeid, subjectypename, description, instituteid, createdby, dateofcreation, subjecttypestatus 
    //subjecttypelogid, subjecttypeid, logdetails, createdby, dateofcreation, subjecttypelogstatus
    public void setsubjecttypeid(String s)
    {
        subjecttypeid = s;
    }
    
    public String getsubjecttypeid()
    {
        return subjecttypeid;
    }
    public void setsubjecttypelogid(String s)
    {
    	subjecttypelogid = s;
    }
    
    public String getsubjecttypelogid()
    {
        return subjecttypelogid;
    }
   
    public void setsubjectypename(String s)
    {
    	subjectypename = s;
    }
    public String getsubjectypename()
    {
        return subjectypename;
    }
    
    public void setDescription(String s)
    {
    	description = s;
    }

    public String getDescription()
    {
        return description;
    }
    
    
    public void setsubjecttypestatus(String s)
    {
    	subjecttypestatus = s;
    }

    public String getsubjecttypestatus()
    {
        return subjecttypestatus;
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
    private static String subjecttypeid = null;
    private static String subjectypename = null;

    private static String description = null;
    private static String subjecttypestatus = null;
    private static String ipaddress = null;
    private static String CreatedBy = null;
    private static String instituteid = null;
    private static String logdetails = null;
    private static String subjecttypelogid = null;
    private static String subjecttypelogstatus = null;
}



    
