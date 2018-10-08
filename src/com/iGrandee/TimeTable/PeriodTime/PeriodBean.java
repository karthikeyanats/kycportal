package com.iGrandee.TimeTable.PeriodTime;

public class PeriodBean {
	
	public PeriodBean(){
		
	}
	 
	public String getPeriodid() {
		return periodid;
	}
	public void setPeriodid(String periodid) {
		this.periodid = periodid;
	}
	public String getPeriodtime() {
		return periodtime;
	}
	public void setPeriodtime(String periodtime) {
		this.periodtime = periodtime;
	}
	public String getPeriodnameid() {
		return periodnameid;
	}
	public void setPeriodnameid(String periodnameid) {
		this.periodnameid = periodnameid;
	}
	public String[] getPeriodids() {
		return periodids;
	}
	public void setPeriodids(String[] periodids) {
		this.periodids = periodids;
	}
	public String[] getPeriodtimes() {
		return periodtimes;
	}
	public void setPeriodtimes(String[] periodtimes) {
		this.periodtimes = periodtimes;
	}
	public String[] getPeriodnameids() {
		return periodnameids;
	}
	public void setPeriodnameids(String[] periodnameids) {
		this.periodnameids = periodnameids;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	
	
	
	private String periodid			= null;
	private String periodtime		= null;
	private String periodnameid		= null;
	private String periodids[]		= null;
	private String periodtimes[]	= null;
	private String periodnameids[]	= null;
	private String instituteid		= null;
	private String status			= null;

}
