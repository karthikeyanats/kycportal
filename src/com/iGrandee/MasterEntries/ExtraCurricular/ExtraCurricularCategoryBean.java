package com.iGrandee.MasterEntries.ExtraCurricular;

public class ExtraCurricularCategoryBean
{
	public ExtraCurricularCategoryBean()
    {
    }

	public String getExtracurricularcategoryid() {
		return extracurricularcategoryid;
	}
	public void setExtracurricularcategoryid(String extracurricularcategoryid) { 
		this.extracurricularcategoryid = extracurricularcategoryid;
	}
	public String[] getExtcurricularcategoryname() {
		return extcurricularcategoryname;
	}
	public void setExtcurricularcategoryname(String[] extcurricularcategoryname) {
		this.extcurricularcategoryname = extcurricularcategoryname;
	}
	public String getCurriculardescription() {
		return curriculardescription;
	}
	public void setCurriculardescription(String curriculardescription) {
		this.curriculardescription = curriculardescription;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getDateofcreation() {
		return dateofcreation;
	}
	public void setDateofcreation(String dateofcreation) {
		this.dateofcreation = dateofcreation;
	}
	public String getCurricularstatus() {
		return curricularstatus;
	}
	public void setCurricularstatus(String curricularstatus) {
		this.curricularstatus = curricularstatus;
	}
	public String getInstituteid() {
		return instituteid;
	}

	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
  
	
	  private String extracurricularcategoryid= null;
	  private String[] extcurricularcategoryname= null;
	  private String curriculardescription= null;
	  private String createdby= null;
	  private String dateofcreation= null;
	  private String curricularstatus= null;
	  private String instituteid= null;


}
