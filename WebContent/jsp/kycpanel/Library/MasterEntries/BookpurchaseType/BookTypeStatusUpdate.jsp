<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.BookpurchaseType.BookpurchaseTypeEntry" />
<jsp:useBean id="bookpurchasetypebean" scope="page"
	class="com.iGrandee.Library.MasterEntries.BookpurchaseType.BookpurchaseTypeBean" />

<%@ page language="java" import="java.util.*"%>
	
	
	<%
	int courseList=0;
	String bookpurchasetypeid = request.getParameter("bookpurchasetypeid");
	String bookpurchasetypename = request.getParameter("bookpurchasetypename");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getLocalAddr();
	String flage=request.getParameter("flage");
	String Status="";
	String LogStatus="";
	String message="";
	String return_file="";
	bookpurchasetypebean.setBookpurchasetypeid(bookpurchasetypeid);
	bookpurchasetypebean.setBookpurchasetypename(bookpurchasetypename);
	bookpurchasetypebean.setDescription(descryption);
	bookpurchasetypebean.setCreatedby(createdby);
	bookpurchasetypebean.setInstituteid(instituteid);
	bookpurchasetypebean.setIpaddress(ipaddress);
	bookpurchasetypebean.setBooktypelogstatus("A");
	
	if(flage.equals("Trash"))
	{	
		LogStatus="Trashed";
		Status="T";
		bookpurchasetypebean.setLogstatus(LogStatus); 
		bookpurchasetypebean.setBooktypestatus(Status);
		courseList = query_object.BookTypeStatusUpdate(bookpurchasetypebean); 
		message="Trashed";
		return_file =request.getContextPath()+"/jsp/Library/MasterEntries/BookpurchaseType/BookTypeList.jsp";

	}
	 else if(flage.equals("Delete"))
	{	
		LogStatus="Deleted";
		Status="X";
		bookpurchasetypebean.setLogstatus(LogStatus); 
		bookpurchasetypebean.setBooktypestatus(Status);
		courseList = query_object.BookTypeStatusUpdate(bookpurchasetypebean); 
		message="Deleted";
		 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/BookpurchaseType/BookTypeTrashListview.jsp";

	} else if(flage.equals("Restore"))
	{	
		LogStatus="Restored";
		Status="A";
		bookpurchasetypebean.setLogstatus(LogStatus); 
		bookpurchasetypebean.setBooktypestatus(Status);
		courseList = query_object.BookTypeStatusUpdate(bookpurchasetypebean); 
		message="Restored";
		 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/BookpurchaseType/BookTypeTrashListview.jsp";

	}
	
	
	if(courseList==0)
	{
		message = " Book Purchase Type "+message+" failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Book Purchase Type "+message;

	} 
	
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);


%>