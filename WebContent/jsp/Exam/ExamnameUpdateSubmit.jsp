<jsp:useBean id="examname_query_object" scope="page"
	class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
 
<%@ page language="java" import="java.util.*"%>
<%
	String op=null;
	String return_file=null;
	String sessionid="";
	int result = 0;

	try{
		String examname=request.getParameter("examname");
		String examremarks=request.getParameter("examremarks");
		String examnameid=request.getParameter("examnameid1_hidden");
		//System.out.println("examnameid>>>>"+examnameid);	
		String createdby1 = request.getParameter("createdby1_hidden");
		sessionid=(String)session.getValue("sessionid");
	

		String instituteid = (String)session.getValue("instituteid");
		//String ipaddress = request.getLocalAddr();

		examnameBean.setCreatedby(createdby1);
		examnameBean.setInstituteid(instituteid);
		examnameBean.setSessionid(sessionid);

		examnameBean.setExamnameid(examnameid);
		examnameBean.setExamname(examname);
		examnameBean.setRemarks(examremarks);
		
		result = examname_query_object.UpdateEditExamname(examnameBean);
	
		if(result==1000)
			op="Exam Name already Exists";
		else if(result>0)
			op="Exam Name Successfully Updated";
		else if(result==0)
			op="Exam Name Failed to Update";

	return_file = request.getContextPath()+"/jsp/Exam/ExamnameView.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
	}catch(Exception e){}
%>
