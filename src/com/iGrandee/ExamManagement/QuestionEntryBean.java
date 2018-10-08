package com.iGrandee.ExamManagement;

public class QuestionEntryBean {
	
	public QuestionEntryBean(){
		
	}
	
	private String userid				= null;
	private String lessonid				= null;
	private String occurence			= null;
	private String examtype				= null;
	private String startdate			= null;
	private String enddate				= null;
	private String difficultyfactor		= null;
	private String questiontype			= null;
	private String[] question			= null;
	private String[] answer				= null;
	private String[] correctanswer		= null;
	private String[] totalanswer		= null;
	private String[] mark				= null;
	private String[] time				= null;
	private String[] files				= null;
	private String[] questionid			= null;
	private String[] enddates			= null;
	private String occurences[]			= null;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getLessonid() {
		return lessonid;
	}
	public void setLessonid(String lessonid) {
		this.lessonid = lessonid;
	}
	public String getOccurence() {
		return occurence;
	}
	public void setOccurence(String occurence) {
		this.occurence = occurence;
	}
	public String getExamtype() {
		return examtype;
	}
	public void setExamtype(String examtype) {
		this.examtype = examtype;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getDifficultyfactor() {
		return difficultyfactor;
	}
	public void setDifficultyfactor(String difficultyfactor) {
		this.difficultyfactor = difficultyfactor;
	}
	public String getQuestiontype() {
		return questiontype;
	}
	public void setQuestiontype(String questiontype) {
		this.questiontype = questiontype;
	}
	public String[] getQuestion() {
		return question;
	}
	public void setQuestion(String[] question) {
		this.question = question;
	}
	public String[] getAnswer() {
		return answer;
	}
	public void setAnswer(String[] answer) {
		this.answer = answer;
	}
	public String[] getCorrectanswer() {
		return correctanswer;
	}
	public void setCorrectanswer(String[] correctanswer) {
		this.correctanswer = correctanswer;
	}
	public String[] getTotalanswer() {
		return totalanswer;
	}
	public void setTotalanswer(String[] totalanswer) {
		this.totalanswer = totalanswer;
	}
	public String[] getMark() {
		return mark;
	}
	public void setMark(String[] mark) {
		this.mark = mark;
	}
	public String[] getTime() {
		return time;
	}
	public void setTime(String[] time) {
		this.time = time;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public String[] getQuestionid() {
		return questionid;
	}
	public void setQuestionid(String[] questionid) {
		this.questionid = questionid;
	}
	public String[] getEnddates() {
		return enddates;
	}
	public void setEnddates(String[] enddates) {
		this.enddates = enddates;
	}
	public String[] getOccurences() {
		return occurences;
	}
	public void setOccurences(String[] occurences) {
		this.occurences = occurences;
	}

}
