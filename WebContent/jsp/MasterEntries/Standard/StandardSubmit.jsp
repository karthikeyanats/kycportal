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
String return_file = null;
String message = "";
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	standardname = request.getParameter("standardname");
	standarddescription = request.getParameter("standarddescription");
	boardid = request.getParameter("standardboard");
	groupstatus = request.getParameter("groupstatus");
	
	standardBean.setStandardname(standardname);
	standardBean.setDescription(standarddescription);
	standardBean.setBoardid(boardid);
	standardBean.setInstituteid(instituteid);
	standardBean.setGroupstatus(groupstatus);
	standardBean.setCreatedby(userid);
	no_of_rows = standardQuery.insertStandard(standardBean);
	if(no_of_rows ==1000)
	{
		message = "The Follwoing Standard Name Already Exists :"+standardname;
		no_of_rows=0;
	}
	else if(no_of_rows >0)
		message = "Standard Successfully Inserted";
	else
		message = "Standard Insertion Failed";
	
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Standard/StandardCreation.jsp";
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);

		
}catch(Exception e){}	
	
	
%>