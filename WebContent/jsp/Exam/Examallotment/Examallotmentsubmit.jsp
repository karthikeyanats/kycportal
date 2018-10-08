<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean,com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>

<%
com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  ExamAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean ExamAllotmentBean = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean();

String instituteid = null;
String examnameid = "";
String standardscheduleid = "";
String allotedby = "";
int no_of_rows= 0 ;
String op = "";
String return_file = null;
int result = 0;
try
{
	instituteid = (String)session.getValue("instituteid");
	//System.out.println("instituteid>>>"+instituteid);
	allotedby = (String)session.getValue("userid");
	//System.out.println("allotedby>>>"+allotedby);
	examnameid = request.getParameter("req_examnameid1");
	//System.out.println("examnameid>>>"+examnameid);
	//String statusflag 			= request.getParameter("statusflag");
	
	String[] chkBoxId=null;
	chkBoxId= request.getParameterValues("chk");
	//System.out.println("chkBoxId>>>"+chkBoxId);
	result = ExamAllotmentQuery.insertExamAllotment(examnameid,chkBoxId,allotedby,instituteid);
	//System.out.println("result>>>"+result);
	
	if(result>0)
		op="Exam Alloted Successfully";
	else
		op="Exam Allotment Failed";

	return_file = request.getContextPath()+"/jsp/Exam/Examallotment/Examallotment.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	


		
}catch(Exception e){}	
	
	
%>