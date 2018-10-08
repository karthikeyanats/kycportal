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
	
	int trashlist = query_object.Deletegroups(instituteBean);
	String op = "Deleted";
	
	String message="";
	if(trashlist >0)
		message = "Subject Type Successfully  Deleted";
	else
		message = " Subject Type Deletion Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/SubjectType/SubjectTypeTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
