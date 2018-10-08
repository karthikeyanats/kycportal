<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="community_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityQuery" />
<jsp:useBean id="communityBean" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityBean" />
<%@ page language="java" import="java.util.*"%>
<%
	String op="";
	int result=0;
	String return_file = null;
try{
	String communityid=request.getParameter("communityid_hidden");
	//System.out.println("RESTORE Examname id:::>>>"+examnameid);
	//String createdby = request.getParameter("createdby_hidden");
	//System.out.println("RESTORE Createdby id:::>>>"+createdby);
	String instituteid = (String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();
	communityBean.setCommunityid(communityid);
	//communityBean.setCreatedby(createdby);
	communityBean.setInstituteid(instituteid);
	//communityBean.setIpaddess(ipaddress);

	result = community_query_object.RestoreCommunity(communityBean);
		if (result>0)
			op="Community Successfully Restored";
		else
			op="Community Restore failed";
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Community/CommunityView.jsp";

	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
}catch(Exception e){}
%>
