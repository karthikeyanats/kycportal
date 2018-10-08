<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String subjecttypename=request.getParameter("subjecttypename");
String subjecttypeid=request.getParameter("subjecttypeid");

	String descryption=request.getParameter("deptdescription");
	String groupid=request.getParameter("groupid");
	String createdby =(String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String LogStatus = "Updated";
	
instituteBean.setsubjecttypeid(subjecttypeid);
instituteBean.setsubjectypename(subjecttypename);
instituteBean.setDescription(descryption.replaceAll("&quot;","\""));
instituteBean.setsubjecttypelogstatus(LogStatus);



instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

int courseList = query_object.UpdateEdittSubjectType(instituteBean);
String op = "Updated";

String message="";
if(courseList ==1)
{
	message = "Subject Type Successfully  Updated";
}
else if(courseList ==0)
{
	message = " Subject Type Updation Failed";	
}else if(courseList ==1000)
{
	message = " Subject Type Name Already Exist ";	
	courseList=1000; 
}


	String return_file =request.getContextPath()+"/jsp/MasterEntries/SubjectType/SubjectTypeList.jsp";
 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
 	
%>
