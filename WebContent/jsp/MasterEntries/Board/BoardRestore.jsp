<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />

<%@ page language="java" import="java.util.*"%>
<%
String mediumid=request.getParameter("mediumidaaa");
String mediumname=request.getParameter("mediumname");
	String boardid=request.getParameter("boardid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setboardid(boardid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

String op = "Restored";
int trashlist=query_object.Activeboards();


String message="";
if(trashlist >0)
	message = "Board Successfully Restored";
else
	message = "Board Restore Failed";	

	String return_file =request.getContextPath()+"/jsp/MasterEntries/Board/BoardTrashListview.jsp?mediumidaaa="+mediumid+"&mediumname="+mediumname;
 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
 	
 	
%>
