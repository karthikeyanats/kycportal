
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
String subjecttypeid=request.getParameter("subjecttypeid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setsubjecttypeid(subjecttypeid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);

	int courseList = query_object.RestoreSubjectTypes(instituteBean);
	String op = "Restored";
	
	String message="";
	if(courseList >0)
		message = "Subject Type Successfully Restored";
	else
		message = " Subject Type Restore Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/SubjectType/SubjectTypeTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
