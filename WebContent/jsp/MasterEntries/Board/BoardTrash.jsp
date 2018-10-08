<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />


<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String boardid = request.getParameter("boardid");
String boardname = request.getParameter("boardname");
String descryption = request.getParameter("descryption");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String mediumname=request.getParameter("mediumname");

String mediumid=request.getParameter("mediumidaaa");
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setboardstatus(curstatus);
	instituteBean.setboardid(boardid);

	int trashlist = query_object.Updatetashboards();  
	String op = "Trashed";
	
	String message="";
	if(trashlist >0)
		message = "Board Successfully Trashed";
	else
		message = "Board Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Board/BoardList.jsp?mediumidaaa="+mediumid+"&mediumname="+mediumname;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
	 	
%>
