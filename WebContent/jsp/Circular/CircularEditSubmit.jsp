<jsp:useBean id="circularEntryBean" 	scope="page" class="com.iGrandee.Circular.CircularEntryBean"/>
<jsp:useBean id="circularQuery" 		scope="page" class="com.iGrandee.Circular.CircularEntryQuery"/>
<jsp:useBean id="date_object" 			scope="page" class="com.iGrandee.Common.DateTime"/>

<%@ page import="com.iGrandee.Circular.CircularEntryUpload" %>
<%@ page import="java.util.ResourceBundle,java.io.File,java.util.List,java.util.Iterator" %>

<%
	String circularid			= request.getParameter("circularid");
	String Status			= request.getParameter("Status");

	circularEntryBean.setOperation(Status);
	circularEntryBean.setCircularid(circularid);
	int result=circularQuery.dataManipulation(circularEntryBean);
	String resultword = "";

	if(result >0){
		if(Status.equals("Active"))
			resultword="Circular Successfully Restored";
		else if(Status.equals("Delete"))
			resultword="Circular Successfully Deleted";
		else if(Status.equals("Trash"))
			resultword="Circular Successfully Trashed";


			
	}
	else
	{
		resultword="operation Failed";
	}
//	String return_file = "./Circular/CircularView.jsp";

	//response.sendRedirect(request.getContextPath()+"/jsp/Opreation_result_withrequest.jsp?message="+resultword+"&result="+result+"&returnurl="+return_file);
	

	String return_file =request.getContextPath()+"/jsp/Circular/CircularView.jsp";
 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+resultword+"&result="+result+"&returnurl="+return_file);

	
%>