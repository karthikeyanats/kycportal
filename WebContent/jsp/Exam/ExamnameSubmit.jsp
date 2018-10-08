<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
<%
	com.iGrandee.Exam.ExamnameEntry  examnameQuery = new com.iGrandee.Exam.ExamnameEntry();
	com.iGrandee.Exam.ExamnameBean examnameBean= new com.iGrandee.Exam.ExamnameBean();
	String examname = "";
	String remarks = "";
	String sessionid="";
	String instituteid = null;
	String userid = null;
	String op=null;
	String return_file=null;
	int result = 0;
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	//System.out.println("userid>>>>"+userid);
	examname = request.getParameter("examname");
	sessionid=(String)session.getValue("sessionid");
	remarks = request.getParameter("examremarks");
	
	if(remarks.trim() == "")
		remarks = "-";
	examnameBean.setExamname(examname);
	examnameBean.setSessionid(sessionid);
	examnameBean.setRemarks(remarks);
	examnameBean.setCreatedby(userid);
	examnameBean.setInstituteid(instituteid);
	result = examnameQuery.insertExamnameEntry(examnameBean);

	if(result==1000)
		op="Exam Name already Exists";
	else if(result>0)
		op="Examname Successfully Inserted";
	else
		op="Examname Insertion Failed";

	return_file = request.getContextPath()+"/jsp/Exam/ExamnameEntry.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
}catch(Exception e){}	
	
	
%>