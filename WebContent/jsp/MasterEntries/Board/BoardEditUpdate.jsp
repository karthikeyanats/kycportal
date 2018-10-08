<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String boardname=request.getParameter("boardname");
	String descryption=request.getParameter("deptdescription");
	String boardid=request.getParameter("boardid");

	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String mediumname=request.getParameter("mediumname");
String mediumid=request.getParameter("mediumidaaa");
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
instituteBean.setmediumid(mediumid);
	instituteBean.setboardid(boardid);
	instituteBean.setboardname(boardname);
	instituteBean.setdDescription(descryption.replaceAll("&quot;","\""));
	int courseList = query_object.UpdateEdittboards();
	String op = "Updated";
	
	String message="";
	if(courseList ==1)
	{
		message = "Board Successfully  Updated";
	}
	else if(courseList ==0)
	{
		message = "Board Updation Failed";	 
	}
	else if(courseList ==1000)
	{
		message = "Board Name Already Exist";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Board/BoardList.jsp?mediumidaaa="+mediumid+"&mediumname="+mediumname;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
