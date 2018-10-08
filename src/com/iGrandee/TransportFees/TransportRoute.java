/**
 * 
 */
package com.iGrandee.TransportFees;

/**
 * @author selvakumar_v
 *
 */
public class TransportRoute {
	
	private String routename;
	public String getRoutename() {
		return routename;
	}
	public void setRoutename(String routename) {
		this.routename = routename;
	}
	public String getRoutedescription() {
		return routedescription;
	}
	public void setRoutedescription(String routedescription) {
		this.routedescription = routedescription;
	}
	private String routedescription;
	private String dateofcreation;
	private String createdby;
	private String instituteid;
	private String routestatus;
	private String transportoperation;
	
	public String getTransportoperation() {
		return transportoperation;
	}
	public void setTransportoperation(String transportoperation) {
		this.transportoperation = transportoperation;
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
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getRoutestatus() {
		return routestatus;
	}
	public void setRoutestatus(String routestatus) {
		this.routestatus = routestatus;
	}
	
	
}
