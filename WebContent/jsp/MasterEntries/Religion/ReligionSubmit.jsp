<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Religion.ReligionBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>

<%
com.iGrandee.MasterEntries.Religion.ReligionQuery  religionQuery = new com.iGrandee.MasterEntries.Religion.ReligionQuery();
com.iGrandee.MasterEntries.Religion.ReligionBean religionBean= new com.iGrandee.MasterEntries.Religion.ReligionBean();
String religionname = "";
String religiondescription = "";
String instituteid = null;
String userid = null;
String op=null;
String return_file=null;
int result = 0;
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	religionname = request.getParameter("religionname");
	religiondescription = request.getParameter("religiondescription");
	
	religionBean.setReligionname(religionname);
	religionBean.setReligiondescription(religiondescription);
	religionBean.setInstituteid(instituteid);
	religionBean.setCreatedby(userid);
	result = religionQuery.insertReligion(religionBean);

	if(result==1000) 
	{ 
		op = " Religion Name  Already Exists";
		result=1000;  
	} 
	else if(result>=1)
	{
		op = "Successfully Religion Inserted";

	}
	else if(result==0)
	{
		op = " Religion insert  failed";	
	}
	
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Religion/ReligionView.jsp";
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
}catch(Exception e){}	
	
	
%>