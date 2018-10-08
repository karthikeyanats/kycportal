<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />


<%@ page language="java" import="java.util.*"%>
<%
String mediumid=request.getParameter("mediumidaaa");
String mediumname=request.getParameter("mediumname");
	String boardid = request.getParameter("boardid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
	instituteBean.setboardid(boardid);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setIpaddess(ipaddress);
	
	int trashlist = query_object.Deleteboards();
	String op = "Deleted";
	
	String message="";
	if(trashlist >0)
		message = "Board Successfully  Deleted";
	else
		message = "Board Deletion Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Board/BoardTrashListview.jsp?mediumidaaa="+mediumid+"&mediumname="+mediumname;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
	 	
%>
