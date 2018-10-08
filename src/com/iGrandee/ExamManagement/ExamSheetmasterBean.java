package com.iGrandee.ExamManagement;

public class ExamSheetmasterBean {
	
	public ExamSheetmasterBean(){
		
	}
	
	public Long getQsid() {
		return qsid;
	}
	public void setQsid(Long qsid) {
		this.qsid = qsid;
	}
	public String getExamname() {
		return examname;
	}
	public void setExamname(String examname) {
		this.examname = examname;
	}
	public String getCreateddate() {
		return createddate;
	}
	public void setCreateddate(String createddate) {
		this.createddate = createddate;
	}
	public String getQuestionsheetstatus() {
		return questionsheetstatus;
	}
	public void setQuestionsheetstatus(String questionsheetstatus) {
		this.questionsheetstatus = questionsheetstatus;
	}
	public String getSubjectscheduleid() {
		return subjectscheduleid;
	}
	public void setSubjectscheduleid(String subjectscheduleid) {
		this.subjectscheduleid = subjectscheduleid;
	}
	public String getTemplatetype() {
		return templatetype;
	}
	public void setTemplatetype(String templatetype) {
		this.templatetype = templatetype;
	}
	public String getInstruction() {
		return instruction;
	}
	public void setInstruction(String instruction) {
		this.instruction = instruction;
	}
	
	private Long qsid;
	private String examname; 
	private String createddate;
	private String questionsheetstatus;
	private String subjectscheduleid;
	private String templatetype;
	private String instruction;	

}
