<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.BookpurchaseType.BookpurchaseTypeEntry" />
<jsp:useBean id="bookpurchasetypebean" scope="page"
	class="com.iGrandee.Library.MasterEntries.BookpurchaseType.BookpurchaseTypeBean" />


     
<%@ page language="java" import="java.util.*"%>
<%
	String bookpurchasetypename=request.getParameter("bookpurchasetypename");
	String description=request.getParameter("description");
	String bookpurchasetypeid=request.getParameter("bookpurchasetypeid");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getLocalAddr();
	String Status="A";
	String LogStatus="Updated";
	
	bookpurchasetypebean.setCreatedby(createdby);
	bookpurchasetypebean.setInstituteid(instituteid);
	bookpurchasetypebean.setIpaddress(ipaddress);
	bookpurchasetypebean.setBookpurchasetypeid(bookpurchasetypeid);
	bookpurchasetypebean.setBookpurchasetypename(bookpurchasetypename.replaceAll("&quot;","\"").trim());
	bookpurchasetypebean.setDescription(description.trim());
	
	bookpurchasetypebean.setBooktypestatus(Status);
	bookpurchasetypebean.setBooktypelogstatus(Status);
	bookpurchasetypebean.setLogstatus(LogStatus); 
	
	int courseList = query_object.UpdateEdittBookType(bookpurchasetypebean);
	String message="";
	

	
	if(courseList==1000)
	{
		message = " Book Purchase Type Name  Already Exists";
	    courseList=1000;
	}
	else if(courseList==0)
	{
		message = " Book Purchase Type Updation  failed";

	}
	else if(courseList>=1)
	{
		message = "Successfully Book Purchase Type Updated";

	}
		
		String return_file =request.getContextPath()+"/jsp/Library/MasterEntries/BookpurchaseType/BookTypeList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
