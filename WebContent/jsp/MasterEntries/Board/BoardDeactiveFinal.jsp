<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />


<%@ page language="java" import="java.util.*"%>
<%
String mediumname=request.getParameter("mediumname");

	String boardid = request.getParameter("boardid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setboardid(boardid);
instituteBean.setCreatedBy(createdby);
String mediumid=request.getParameter("mediumidaaa");

instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
instituteBean.setCreatedBy(createdby);
	
	int trashlist = query_object.boardsDeactivate();
	String op = "Deactivated";
	
	String message=""; 
	if(trashlist >0)
		message = "Board Successfully  Deactivated";
	else
		message = "Board Deactivation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Board/BoardList.jsp?mediumidaaa="+mediumid+"&mediumname="+mediumname;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	

%>
