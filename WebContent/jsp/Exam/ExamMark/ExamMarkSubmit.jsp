<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
try{
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
	//String stdscheduleid	=	null;
	int result=0;
	String op=null;
	String return_file=null;
	String examschid	=	null;
	String[] chkBoxId=null;
	String[] markTaken=null;

	String createdby 		=	(String)session.getValue("userid");
	//stdscheduleid=request.getParameter("stdscheduleid");
	examschid=request.getParameter("req_examschid");
	
	//System.out.println("mark_examschid"+examschid);	
	//out.println("examschid-->"+examschid);
	
	chkBoxId= request.getParameterValues("chk");
	//System.out.println("chkBoxId>>>"+chkBoxId);
	markTaken= request.getParameterValues("marktaken");
	//System.out.println("markTaken>>>"+markTaken);
	String ipaddress = request.getRemoteAddr();
	//System.out.println("mark_ipaddress>>>"+ipaddress);
	//System.out.println("chkBoxId,stdscheduleid,approvedby,rollno-->"+chkBoxId+"--"+examschid+"--"+createdby+"--"+markTaken);
	result = examAllotmentQuery.insertExammark(examschid,chkBoxId,markTaken,createdby,ipaddress);
	if (result>0)
		op="Examination Mark Successfully Inserted";
	else
		op="Examination Mark Insertion Failed"; 
	return_file =request.getContextPath()+"/jsp/Exam/ExamMark/ExamMarkEntry.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){}
%>
