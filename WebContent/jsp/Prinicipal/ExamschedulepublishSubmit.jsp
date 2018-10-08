<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>
	
<%
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean ExamAllotmentBean = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean();
	ExamAllotmentQuery	schedule	= new ExamAllotmentQuery();

	String op="";
	int result=0;
	String return_file = null;
	String[] checkstandard=null;
	String[] exmallotid=null;
	
try{	
		checkstandard= request.getParameterValues("checkstandard");
		exmallotid=request.getParameterValues("exallotid");
		//System.out.println("checkstandard>>>"+checkstandard[0]);
		String allotedby 		=	(String)session.getValue("userid");
		//System.out.println("allotedby>>>"+allotedby);
		result					= schedule.updatePublishExam(checkstandard,exmallotid);			
		
		if(result >0)
			op	= "Subject(s) Successfully Published for the Exam.";
		else
			op	= "Subject(s) Unable to Update for the Exam.";
		
		return_file = request.getContextPath()+"/jsp/Prinicipal/ExamScheduleView.jsp";
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	}catch(Exception e){}
%>	