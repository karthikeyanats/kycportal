/**
 * 
 */
package com.iGrandee.TransportFees;

/**
 * @author sindhuja_v
 *
 */
public class FeesSettings {

	// Yearofsession wise Feestype insertion process
	
	private String institutetransporttypeid;
	
	public String getInstitutetransporttypeid() {
		return institutetransporttypeid;
	}
	public void setInstitutetransporttypeid(String institutetransporttypeid) {
		this.institutetransporttypeid = institutetransporttypeid;
	}
	public String getTransportfeestypeid() 
	{
		System.out.println("get() in transportfeestypeid ==>"+transportfeestypeid);
		return transportfeestypeid;
	}
	public void setTransportfeestypeid(String transportfeestypeid) {
		this.transportfeestypeid = transportfeestypeid;
	}
	public String getDateofcreation() {
		return dateofcreation;
	}
	public void setDateofcreation(String dateofcreation) {
		this.dateofcreation = dateofcreation;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getInstitutetransporttypestatus() {
		return institutetransporttypestatus;
	}
	public void setInstitutetransporttypestatus(String institutetransporttypestatus) {
		this.institutetransporttypestatus = institutetransporttypestatus;
	}
	
	private String transportfeestypeid;
	private String dateofcreation;
	private String createdby;
	private String institutetransporttypestatus;
	private String sessionid;
	
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	
	

// Stagewise Amount insertion Process	
	
	private String transportfeessettingsid;
	private String transportstageid;
	private String transportcategoryid;
	private String transportfeesamount;
	private String transportfeessettingstatus;
	
	public String getTransportfeessettingsid() {
		return transportfeessettingsid;
	}
	public void setTransportfeessettingsid(String transportfeessettingsid) {
		this.transportfeessettingsid = transportfeessettingsid;
	}
	public String getTransportstageid() {
		return transportstageid;
	}
	public void setTransportstageid(String transportstageid) {
		this.transportstageid = transportstageid;
	}
	public String getTransportcategoryid() {
		return transportcategoryid;
	}
	public void setTransportcategoryid(String transportcategoryid) {
		this.transportcategoryid = transportcategoryid;
	}
	public String getTransportfeesamount() {
		return transportfeesamount;
	}
	public void setTransportfeesamount(String transportfeesamount) {
		this.transportfeesamount = transportfeesamount;
	}
	public String getTransportfeessettingstatus() {
		return transportfeessettingstatus;
	}
	public void setTransportfeessettingstatus(String transportfeessettingstatus) {
		this.transportfeessettingstatus = transportfeessettingstatus;
	}
	
	
	// Category insertion Process	
			
		private String transportcategoryname;
		private String transportcategorystatus;
		private String transportcategorysdescription;
		
		
		public String getTransportcategorysdescription() {
			return transportcategorysdescription;
		}
		public void setTransportcategorysdescription(
				String transportcategorysdescription) {
			this.transportcategorysdescription = transportcategorysdescription;
		}
		public String getTransportcategoryname() {
			return transportcategoryname;
		}
		public void setTransportcategoryname(String transportcategoryname) {
			this.transportcategoryname = transportcategoryname;
		}
		public String getTransportcategorystatus() {
			return transportcategorystatus;
		}
		public void setTransportcategorystatus(String transportcategorystatus) {
			this.transportcategorystatus = transportcategorystatus;
		}

		
	
	
	
}
