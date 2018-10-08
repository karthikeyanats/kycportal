<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String boardid=request.getParameter("boardid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String mediumid=request.getParameter("mediumidaaa");
String mediumname=request.getParameter("mediumname");

String ipaddress = request.getRemoteAddr();

instituteBean.setboardid(boardid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
	int courseList = query_object.Restoreboards();
	String op = "Activated";
	String message="";
	if(courseList >0)
		message = " Board Successfully Activated";
	else
		message = "Board Activation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Board/BoardDeactive.jsp?mediumidaaa="+mediumid+"&mediumname="+mediumname;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
