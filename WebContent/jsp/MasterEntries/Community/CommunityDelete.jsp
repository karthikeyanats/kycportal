<jsp:useBean id="community_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityQuery" />
<jsp:useBean id="communityBean" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.io.*,java.util.*"%>

<%
	String op="";
	int result=0;
	String return_file = null;
try{
	String communityid = request.getParameter("communityid_hidden");
	//System.out.println("DELETE communityid::::>>>"+communityid);
	//String createdby=request.getParameter("createdby_hidden");
	//System.out.println("DELETE createdby::::>>>"+createdby);
	//String createdby = "1";
	String instituteid = (String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();
	communityBean.setCommunityid(communityid);
	//communityBean.setCreatedby(createdby);
	communityBean.setInstituteid(instituteid);
	//examnameBean.setIpaddess(ipaddress);
	
	result = community_query_object.DeleteCommunity(communityBean);
	if(result>0)
	{
	op="Community Successfully Deleted";
	}
	else
	{
		op="Community Deletion Failed";
	}
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Community/CommunityCreation.jsp";

	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){}
%>
