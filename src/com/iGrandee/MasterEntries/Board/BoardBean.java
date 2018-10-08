package com.iGrandee.MasterEntries.Board;

public class BoardBean
{
    public BoardBean()
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
    
    public void setboardid(String s)
    {
        boardid = s;
    }
    
    public String getboardid()
    {
        return boardid;
    }
    public void setmediumid(String s)
    {
    	mediumid = s;
    }
    
    public String getmediumid()
    {
        return mediumid;
    }
    public void setboardname(String s)
    {
    	boardname = s;
    }
    public String getboardname()
    {
        return boardname;
    }
    
    public void setdDescription(String s)
    {
    	description = s;
    }

    public String getDescription()
    {
        return description;
    }
    
    
    public void setboardstatus(String s)
    {
    	boardstatus = s;
    }

    public String getboardstatus()
    {
        return boardstatus;
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
    public void setlogboardstatus(String s)
    {
    	logboardstatus = s;
    }

    public String getlogboardstatus()
    {
        return logboardstatus;
    }
    
    private static String operation = null;
    private static String boardid = null;
    private static String boardname = null;

    private static String description = null;
    private static String boardstatus = null;
    private static String ipaddress = null;
    private static String CreatedBy = null;
    private static String instituteid = null;
    private static String logboardstatus = null;
    private static String mediumid = null;


    
}