package com.iGrandee.MasterEntries.AcademicSession;

public class AcademicSessionBean
{//sessionid, sessionname, instituteid, createdby, dateofcreation, ipaddress, sessionstatus, description
    public AcademicSessionBean()
    {
    }
    public void setOperation(String operation)
    {
    	this.operation = operation;
    }

    public String getOperation()
    {
        return operation;
    }
 
    public void setsessionid(String sessionid)
    {
    	this.sessionid = sessionid;
    }
    
    public String getsessionid()
    {
        return sessionid;
    }
    public void setsessionlogid(String sessionlogid)
    {
    	this.sessionlogid = sessionlogid;
    }
    
    public String getsessionlogid()
    {
        return sessionlogid;
    }
   
    public void setsessionname(String subjectypename)
    {
    	this.subjectypename = subjectypename;
    }
    public String getsessionname()
    {
        return subjectypename;
    }
    
    public void setDescription(String description)
    {
    	this.description = description;
    }

    public String getDescription()
    {
        return description;
    }
    
    
    public void setsessionstatus(String sessionstatus)
    {
    	this.sessionstatus =sessionstatus;
    }

    public String getsessionstatus()
    {
        return sessionstatus;
    }
    
    
    public void setIpaddess(String ipaddress)
    {
    	this.ipaddress = ipaddress;
    }

    public String getIpaddess()
    {
        return ipaddress;
    }
    public void setCreatedBy(String CreatedBy)
    {
    	this.CreatedBy = CreatedBy;
    }

    public String getCreatedBy()
    {
        return CreatedBy;
    
    }
    public void setinstituteid(String instituteid)
    {
    	this.instituteid = instituteid;
    }

    public String getinstituteid()
    {
        return instituteid;
    }
   
    public void setsessionlogstatus(String sessionlogstatus)
    {
    	this.sessionlogstatus = sessionlogstatus;
    }

    public String getsessionlogstatus()
    {
        return sessionlogstatus;
    }
    public void setlogdetails(String logdetails)
    {
    	this.logdetails = logdetails;
    }

    public String getlogdetails()
    {
        return logdetails;
    }
   
    /**
	 * @return the monthstart
	 */
	public String getMonthstart() {
		return monthstart;
	}
	/**
	 * @param monthstart the monthstart to set
	 */
	public void setMonthstart(String monthstart) {
		this.monthstart = monthstart;
	}
	/**
	 * @return the yearstart
	 */
	public String getYearstart() {
		return yearstart;
	}
	/**
	 * @param yearstart the yearstart to set
	 */
	public void setYearstart(String yearstart) {
		this.yearstart = yearstart;
	}
	/**
	 * @return the monthend
	 */
	public String getMonthend() {
		return monthend;
	}
	/**
	 * @param monthend the monthend to set
	 */
	public void setMonthend(String monthend) {
		this.monthend = monthend;
	}
	/**
	 * @return the yearend
	 */
	public String getYearend() {
		return yearend;
	}
	/**
	 * @param yearend the yearend to set
	 */
	public void setYearend(String yearend) {
		this.yearend = yearend;
	}

	private String operation = null;
    private String sessionid = null;
    private String subjectypename = null;

    private String description = null;
    private String sessionstatus = null;
    private String ipaddress = null;
    private String CreatedBy = null;
    private String instituteid = null;
    private String logdetails = null;
    private String sessionlogid = null;
    private String sessionlogstatus = null;
    private String monthstart=null;
    private String yearstart=null;
    private String monthend=null;
    private String yearend=null;
    
}



    
