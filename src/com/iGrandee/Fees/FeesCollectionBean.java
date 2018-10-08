
package com.iGrandee.Fees;


public class FeesCollectionBean
{
	//feescollectionid, termfeesid, studentapprovalid, bankname, ddno, dddate, 
	//collectionamount, scholarshipid, pendingstatus, createdby, feescollectiondate,
	//feescollectionstatus	
	public FeesCollectionBean(){}
	
	public String getFeescollectionid() {
		return feescollectionid;
	}
	public void setFeescollectionid(String feescollectionid) {
		this.feescollectionid = feescollectionid;
	}
	public String getTermfeesid() {
		return termfeesid;
	}
	public void setTermfeesid(String termfeesid) {
		this.termfeesid = termfeesid;
	}
	public String getStudentapprovalid() {
		return studentapprovalid;
	}
	public void setStudentapprovalid(String studentapprovalid) {
		this.studentapprovalid = studentapprovalid;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	public String getDdno() {
		return ddno;
	}
	public void setDdno(String ddno) {
		this.ddno = ddno;
	}
	public String getDddate() {
		return dddate;
	}
	public void setDddate(String dddate) {
		this.dddate = dddate;
	}
	public String getCollectionamount() {
		return collectionamount;
	}
	public void setCollectionamount(String collectionamount) {
		this.collectionamount = collectionamount;
	}
	public String getScholarshipid() {
		return scholarshipid;
	}
	public void setScholarshipid(String scholarshipid) {
		this.scholarshipid = scholarshipid;
	}
	public String getPendingstatus() {
		return pendingstatus;
	}
	public void setPendingstatus(String pendingstatus) {
		this.pendingstatus = pendingstatus;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getFeescollectiondate() {
		return feescollectiondate;
	}
	public void setFeescollectiondate(String feescollectiondate) {
		this.feescollectiondate = feescollectiondate;
	}
	public String getFeescollectionstatus() {
		return feescollectionstatus;
	}

	public void setFeescollectionstatus(String feescollectionstatus) {
		this.feescollectionstatus = feescollectionstatus;
	}
	
	public String getPaymenttype() {
		return paymenttype;
	}

	public void setPaymenttype(String paymenttype) {
		this.paymenttype = paymenttype;
	}
	
	private String feescollectionid;
	private String termfeesid;
	private String studentapprovalid;
	private String bankname;
	private String ddno;
	private String dddate;
	private String collectionamount;
	/**
	 * @return the receiptno
	 */
	public String getReceiptno() {
		return receiptno;
	}

	/**
	 * @param receiptno the receiptno to set
	 */
	public void setReceiptno(String receiptno) {
		this.receiptno = receiptno;
	}

	/**
	 * @return the paidamount
	 */
	public String getPaidamount() {
		return paidamount;
	}

	/**
	 * @param paidamount the paidamount to set
	 */
	public void setPaidamount(String paidamount) {
		this.paidamount = paidamount;
	}

	private String receiptno;
	private String paidamount;
	
	
	private String scholarshipid;
	private String pendingstatus;
	private String createdby;
	private String feescollectiondate;
	private String feescollectionstatus;
	private String paymenttype;

	public String[] getBanknames() {
		return banknames;
	}

	public void setBanknames(String[] banknames) {
		this.banknames = banknames;
	}

	public String[] getDdnos() {
		return ddnos;
	}

	public void setDdnos(String[] ddnos) {
		this.ddnos = ddnos;
	}

	public String[] getDddates() {
		return dddates;
	}

	public void setDddates(String[] dddates) {
		this.dddates = dddates;
	}

	public String[] getCollectionamounts() {
		return collectionamounts;
	}

	public void setCollectionamounts(String[] collectionamounts) {
		this.collectionamounts = collectionamounts;
	}

	public String[] getScholarshipids() {
		return scholarshipids;
	}

	public void setScholarshipids(String[] scholarshipids) {
		this.scholarshipids = scholarshipids;
	}

	public String[] getFeescollectiondates() {
		return feescollectiondates;
	}

	public void setFeescollectiondates(String[] feescollectiondates) {
		this.feescollectiondates = feescollectiondates;
	}

	public String[] getSchemeforstudentid() {
		return schemeforstudentid;
	}

	public void setSchemeforstudentid(String[] schemeforstudentid) {
		this.schemeforstudentid = schemeforstudentid;
	}

	public String[] getPaymenttypes() {
		return paymenttypes;
	}

	public void setPaymenttypes(String[] paymenttypes) {
		this.paymenttypes = paymenttypes;
	}

	private String banknames[];
	private String ddnos[];
	private String dddates[];
	private String collectionamounts[];
	private String scholarshipids[];
	private String feescollectiondates[];
	private String schemeforstudentid[];
	private String paymenttypes[];
	


	
	
	
	
	
	
	
	
	
}