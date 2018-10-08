<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.BookpurchaseType.BookpurchaseTypeEntry" /> 
<jsp:useBean id="booktypebean" scope="page"
	class="com.iGrandee.Library.MasterEntries.BookpurchaseType.BookpurchaseTypeBean" />

<%@ page language="java" import="java.util.*"%>
<%
String message = "";
	String bookpurchasetype = request.getParameter("bookpurchasetypename");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	
	String LogStatus = "Created";
	
if(descryption.equals(""))
{
	descryption="-";
}

	booktypebean.setBookpurchasetypename(bookpurchasetype.trim());
	booktypebean.setDescription(descryption.trim());
	booktypebean.setCreatedby(createdby);
	booktypebean.setInstituteid(instituteid);
	booktypebean.setIpaddress(ipaddress);
	booktypebean.setBooktypestatus(Status);
	booktypebean.setBooktypelogstatus(Status);
	booktypebean.setLogstatus(LogStatus); 
	int courseList = query_object.insertBookType(booktypebean); 
	

	if(courseList==1000)
	{
		message = " Book Purchase Type Name Already Exists";
	      courseList=1000;  

	}else if(courseList==0)
	{
		message = " Book purchase Type  insert  failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Book purchase Type  Inserted";

	} 
	
		String return_file =request.getContextPath()+"/jsp/Library/MasterEntries/BookpurchaseType/BookTypeEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
 	%>
