
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />


<%@ page language="java" import="java.util.*"%>
<%
	
String subjecttypeid=request.getParameter("subjecttypeid");
String createdby =  (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

instituteBean.setsubjecttypeid(subjecttypeid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
	int courseList = query_object.Activegroups(instituteBean);
	String op = "Activated";
	
	String message="";
	if(courseList >0)
		message = "Subject Type Successfully  Activated";
	else
		message = " Subject Type Activation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/SubjectType/SubjectTypeDeactiveList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
