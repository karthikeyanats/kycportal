<jsp:useBean id="community_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityQuery" />
<jsp:useBean id="communityBean" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  

<%@ page language="java" import="java.util.*"%>
<%
	String op="";
	int result=0;
	String return_file = null;
	String curstatus = "T";
	try{
	String commid=request.getParameter("communityid_hidden");
	//System.out.println("TRASH Action commid:::>>>"+commid);
	String commname = request.getParameter("communityname_hidden");
	String communitydesc=request.getParameter("communitydescription_hidden");
	String instituteid = (String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();
	String LogStatus = "Trashed";

	
	communityBean.setCommunityid(commid);
	communityBean.setInstituteid(instituteid);
	communityBean.setCommstatus(curstatus);
	result = community_query_object.updateTrashCommunityname(communityBean);
	if(result>0)	
	op="Community Trashed Successfully";
	else
		op="Community Trash Failed";
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Community/CommunityTrashedView.jsp";

	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	}catch(Exception e){}
%>
