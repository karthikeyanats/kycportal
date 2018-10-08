<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />

<%@ page language="java" import="java.util.*"%>
<%
String mediumid = request.getParameter("mediumidaaa");
	String boardname = request.getParameter("boardname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";
	instituteBean.setmediumid(mediumid);

	instituteBean.setboardname(boardname);
	instituteBean.setdDescription(descryption);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setboardstatus(Status);
	

	int courseList = query_object.insertBoards();

	
		String op = "Inserted";
		String message="";
		if(courseList ==1)
		{
			message = "Board Successfully Inserted";
		}
		else if(courseList==0) 
		{
			message = "Board insertion Failed";	
		}
		else if(courseList==1000) 
		{ 
			message = " Board Name  Already Exist";
		      courseList=2;  
		} 

			String return_file =request.getContextPath()+"/jsp/MasterEntries/Board/BoardEntry.jsp";
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
		 	
	
%>
