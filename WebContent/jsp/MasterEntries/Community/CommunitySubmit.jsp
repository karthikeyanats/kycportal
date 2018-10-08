<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>

<%
com.iGrandee.MasterEntries.Community.CommunityQuery  communityQuery = new com.iGrandee.MasterEntries.Community.CommunityQuery();
com.iGrandee.MasterEntries.Community.CommunityBean communityBean= new com.iGrandee.MasterEntries.Community.CommunityBean();
String communityname = "";
String communitydescription = "";
String boardid = "";
String instituteid = null;
String userid = null;
String groupstatus = null;
String op=null;
String return_file=null;
int result = 0;
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	communityname = request.getParameter("communityname");
	communitydescription = request.getParameter("communitydescription");

	communityBean.setCommunityname(communityname);
	communityBean.setCommunitydescription(communitydescription);
	communityBean.setInstituteid(instituteid);
	communityBean.setCreatedby(userid);
	
	result = communityQuery.insertCommunity(communityBean);
	if(result == 1000)
		op="Community Name Already Exist";
	else if(result>0)
		op="Community Successfully Inserted";
	else
		op="Community Insertion Failed";
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Community/CommunityView.jsp";
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);		
}catch(Exception e){}	
	
	
%>