<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardBean,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

<%
com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
com.iGrandee.MasterEntries.Standard.StandardBean standardBean = new com.iGrandee.MasterEntries.Standard.StandardBean();
String standardname = "";
String standarddescription = "";
String boardid = "";
String instituteid = null;
String userid = null;
String groupstatus = null;
int no_of_rows= 0 ;
String message = "";
String return_file = null;
String reqstandardid = null;
String updateoperation = null;
String requeststatus = null;
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	
	updateoperation = request.getParameter("standardoperation");
	if(updateoperation.equals("UpdateStandard"))
	{
	standardname = request.getParameter("standardname");
	standarddescription = request.getParameter("standarddescription");
	boardid = request.getParameter("reqboardid");
	groupstatus = request.getParameter("groupstatus");
	reqstandardid = request.getParameter("reqstandardid");
	
	out.println(reqstandardid+"<br>");
	out.println(standarddescription+"<br>");
	out.println(boardid+"<br>");
	out.println(groupstatus+"<br>");
	out.println(reqstandardid+"<br>");
	
	
	standardBean.setStandardid(reqstandardid);
	standardBean.setStandardname(standardname);

	standardBean.setDescription(standarddescription);
	standardBean.setBoardid(boardid);
	standardBean.setInstituteid(instituteid);
	standardBean.setGroupstatus(groupstatus);
	no_of_rows = standardQuery.updateStandard(standardBean);
	if(no_of_rows ==1000)
	{
		message = "The Follwoing Standard Name Already Exists :"+standardname;
		no_of_rows=0;
	}
	else if(no_of_rows >0)
		message = "Standard Successfully Updated";
	else
		message = "Standard Updation Failed";
	
	return_file =request.getContextPath()+"/jsp/MasterEntries/Standard/StandardCreation.jsp";
	}
	else if(updateoperation.equals("UpdateStandardStatus"))
	{
		reqstandardid = request.getParameter("reqstandardid");
		requeststatus = request.getParameter("requeststatus");
		
		standardBean.setStandardid(reqstandardid);
		standardBean.setStandardstatus(requeststatus);
		no_of_rows = standardQuery.updateStandardStatus(standardBean);
		if(requeststatus.equals("T"))
		{
			if(no_of_rows >0)
				message = "Standard Successfully Trashed";
			else
				message = "Standard Trash Failed";
		}
		if(requeststatus.equals("X"))
		{
			if(no_of_rows >0)
				message = "Standard Successfully Deleted";
			else
				message = "Standard Deletion Failed";
		}
		
		if(requeststatus.equals("A"))
		{
			if(no_of_rows >0)
			message = "Standard Successfully Restored";
			else
			message = "Standard Restore Failed";
			
		}
		if(requeststatus.equals("D"))
		{
			if(no_of_rows >0)
			message = "Standard Successfully Deleted";
			else
			message = "Standard Deletion Failed";
			
		}
		return_file =request.getContextPath()+"/jsp/MasterEntries/Standard/StandardList.jsp";
	}
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);

		
}catch(Exception e){}	
	
	
%>